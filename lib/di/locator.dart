import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/core/constants/app_images.dart';
import 'package:palink_v2/core/constants/prompts.dart';
import 'package:palink_v2/data/api/auth_api.dart';
import 'package:palink_v2/data/api/chat_api.dart';
import 'package:palink_v2/data/dao/character_dao.dart';
import 'package:palink_v2/data/dao/character_quest_dao.dart';
import 'package:palink_v2/data/dao/mindset_dao.dart';
import 'package:palink_v2/data/database/app_database.dart';
import 'package:palink_v2/data/entities/character_entity.dart';
import 'package:palink_v2/data/entities/mindset_entity.dart';
import 'package:palink_v2/data/repository/auth_repositoryImpl.dart';
import 'package:palink_v2/data/repository/character_quest_repositoryImpl.dart';
import 'package:palink_v2/data/repository/character_repositoryImpl.dart';
import 'package:palink_v2/data/repository/chat_repositoryImpl.dart';
import 'package:palink_v2/data/repository/user_repositoryImpl.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';
import 'package:palink_v2/domain/repository/auth_repository.dart';
import 'package:palink_v2/domain/repository/character_quest_repository.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';
import 'package:palink_v2/domain/usecase/create_conversation_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_characters_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_analyze_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_initial_message_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/domain/usecase/sign_up_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/controller/login_view_model.dart';
import 'package:palink_v2/presentation/screens/auth/controller/signup_view_model.dart';
import 'package:palink_v2/presentation/screens/character_select/controller/character_select_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/feedback/controller/feedback_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common/sqlite_api.dart';
import '../data/repository/ai_repositoryImpl.dart';
import '../data/repository/mindset_repositoryImpl.dart';
import '../domain/usecase/generate_tip_usecase.dart'; // Import GenerateTipUsecase
import '../domain/usecase/login_usecase.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  _setupDio();
  _setupApis();
  _setupRepositories(prefs);
  _setupAI();
  _setupUseCases();
  _setupViewModels();

  final database = await _setupDatabase();
  await _initializeDatabase(database.characterDao, database.mindsetDao);
}

void _setupDio() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("REQUEST[${options.method}] => PATH: ${options.path}, DATA: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print("ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
        return handler.next(e);
      },
    ));
    return dio;
  });
}

void _setupApis() {
  getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<Dio>()));
  getIt.registerLazySingleton<ChatApi>(() => ChatApi(getIt<Dio>()));
}

void _setupRepositories(SharedPreferences prefs) {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthApi>(), prefs));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt<ChatApi>()));
  getIt.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl());
  getIt.registerLazySingleton<MindsetRepository>(() => MindsetRepositoryImpl());
}

void _setupAI() {
  getIt.registerLazySingleton<ChatOpenAI>(() => ChatOpenAI(
    apiKey: dotenv.env['API_KEY']!,
    defaultOptions: const ChatOpenAIOptions(
      temperature: 0.8,
      model: 'gpt-4-turbo',
      maxTokens: 600,
    ),
  ));
  getIt.registerLazySingleton<ConversationBufferMemory>(() => ConversationBufferMemory(
    memoryKey: 'history',
    inputKey: 'input',
    returnMessages: true,
  ));
  getIt.registerLazySingleton<ConversationBufferMemory>(() => ConversationBufferMemory(
    memoryKey: 'history',
    inputKey: 'input',
    returnMessages: true,
  ), instanceName: 'tipMemory');
  getIt.registerLazySingleton<ConversationChain>(() => ConversationChain(
      memory: getIt<ConversationBufferMemory>(),
      llm: getIt<ChatOpenAI>(),
      prompt: ChatPromptTemplate.fromTemplate('''
      당신은 마지막 말에 대해 적절한 답변을 해야합니다.
      당신은 USER 를 {userName}으로 부르세요. rejection_score는 누적되어야하고 만약 -5 이하면 is_end를 즉시 1로 설정하세요.
      다음은 당신에 대한 설명입니다.
      {description}
      답변으로 'text', 'feeling', 'expected_emotion', 'rejection_score', 'affinity_score', 'is_end'을 반드시 JSON 객체로 리턴하세요. ("```"로 시작하는 문자열을 생성하지 마세요)
      {chat_history}
      {input}
    '''),
      outputKey: 'response'
  ));
  getIt.registerLazySingleton<LLMChain>(() => LLMChain(
    prompt: ChatPromptTemplate.fromTemplate('''
      당신은 다음 설명에 해당하는 적절한 답변을 해야합니다. 
      답변으로 'answer', 'reason' 을 반드시 JSON 객체로 리턴하세요.
      당신의 대화 상대는 AI 캐릭터입니다. 당신은 USER의 입장에서 대답을 해야합니다.
      
      {input}
    '''),
    llm: getIt<ChatOpenAI>(),
    memory: getIt<ConversationBufferMemory>(instanceName: 'tipMemory'),
  ));
  getIt.registerLazySingleton<LLMChain>(() => LLMChain(
    prompt: ChatPromptTemplate.fromTemplate('''
      당신은 다음의 거절 점수 표와 대화 기록들을 보고, 사용자의 대화 능력을 평가해야합니다. 거절 점수 표는 캐릭터마다 다릅니다.
      반드시 한국어로 하며, AI 캐릭터의 말투를 사용해서 평가해주세요.
      
      {input}
      
      답변으로 'evaluation' (string), 'used_rejection' (string), 'final_rejection_score' (int) 을 반드시 JSON 객체로 리턴하세요.
      'evaluation'은 사용자의 대화 능력을 AI의 입장에서 200자 이내로 평가한 문자열입니다. 'evalution' 은 사용자의 대화능력을 평가할 뿐 아니라 사용자의 대화 능력을 개선할 수 있는 피드백을 제공해야합니다.
      'used_rejection'은 사용자가 대화에서 '사용한 거절 능력(해당 능력의 점수)'의 목록을 나타냅니다. 아이템의 구분은 ',' 로 나타냅니다. 
      'final_rejction_score'은 총 거절 점수입니다.
      
    '''),
    llm: getIt<ChatOpenAI>(),
  ), instanceName: 'analyzeChain');

  getIt.registerLazySingleton<AIRepository>(() => AIRepositoryImpl(
    getIt<ChatOpenAI>(),
    getIt<ConversationBufferMemory>(),
    getIt<ConversationBufferMemory>(instanceName: 'tipMemory'),
    getIt<ConversationChain>(),
    getIt<LLMChain>(),
    getIt<LLMChain>(instanceName: 'analyzeChain'),
  ));
  getIt.registerLazySingleton<CharacterQuestRepository>(() => CharacterQuestRepositoryImpl(getIt()));
}

void _setupUseCases() {
  getIt.registerFactory<CreateConversationUseCase>(() => CreateConversationUseCase(getIt<ChatRepository>(), getIt<GetUserInfoUseCase>()));
  getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<SignUpUseCase>(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<GetUserInfoUseCase>(() => GetUserInfoUseCase(getIt<UserRepository>()));
  getIt.registerFactory<GetUserUseCase>(() => GetUserUseCase(getIt<UserRepository>()));
  getIt.registerFactory<FetchCharactersUsecase>(() => FetchCharactersUsecase(getIt<CharacterRepository>()));
  getIt.registerFactory<GenerateInitialMessageUsecase>(() => GenerateInitialMessageUsecase());
  getIt.registerFactory<FetchChatHistoryUsecase>(() => FetchChatHistoryUsecase(getIt<ChatRepository>()));
  getIt.registerFactory<SendUserMessageUsecase>(() => SendUserMessageUsecase(getIt<ChatRepository>(), getIt<GenerateResponseUsecase>()));
  getIt.registerFactory<GenerateResponseUsecase>(() => GenerateResponseUsecase(getIt<GetUserInfoUseCase>(), getIt<FetchChatHistoryUsecase>(), getIt<GenerateTipUsecase>()));
  getIt.registerFactory<GenerateTipUsecase>(() => GenerateTipUsecase());
  getIt.registerFactory<GenerateAnalyzeUsecase>(() => GenerateAnalyzeUsecase());
  getIt.registerFactory<GetRandomMindsetUseCase>(() => GetRandomMindsetUseCase(getIt<MindsetRepository>()));

}

void _setupViewModels() {
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(loginUseCase: getIt<LoginUseCase>()));
  getIt.registerFactory<SignupViewModel>(() => SignupViewModel(signUpUseCase: getIt<SignUpUseCase>()));
  getIt.registerFactory<MypageViewModel>(() => MypageViewModel(getUserUseCase: getIt<GetUserUseCase>()));
  getIt.registerLazySingleton<CharacterSelectViewModel>(() => CharacterSelectViewModel(fetchCharactersUsecase: getIt<FetchCharactersUsecase>()));
  getIt.registerFactory<TipViewModel>(() => TipViewModel());
}

Future<AppDatabase> _setupDatabase() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton<CharacterDao>(database.characterDao);
  getIt.registerSingleton<MindsetDao>(database.mindsetDao);
  getIt.registerSingleton<CharacterQuestDao>(database.characterQuestDao);
  return database;
}

Future<void> _initializeDatabase(CharacterDao characterDao, MindsetDao mindsetDao) async {
  final characters = [
    CharacterEntity(
      characterId: 1,
      name: '미연',
      type: '동정유발형',
      requestStrength: 1,
      prompt: Prompt.miyeonPrompt,
      description: '''미연은 매우 감성적인 타입이에요.💦
      부탁이 거절되면 실망하거나 슬퍼할 수 있어요
      미연은 내성적이지만 친구들에게는 따뜻하고 배려심이 많아 깊은 관계를 맺고 있으며, 친구들의 고민을 잘 들어줘요
      미연의 부탁을 공감하고 이해하며 부드럽게 거절하는 것이 중요해요''',
      image: ImageAssets.char1,
      analyzePrompt: Prompt.miyeonAnalyzePrompt,
    ),
    CharacterEntity(
      characterId: 2,
      name: '세진',
      type: '은혜갚음형',
      requestStrength: 2,
      prompt: Prompt.sejinPrompt,
      description: '''세진은 논리적이고 책임감이 강한 타입이에요.⚖️
      항상 이득과 손해를 따지며, 과거에 도와줬던 일에 대해서는 반드시 상대방이 갚아야 한다고 생각해요.
      이성적이고 차분하게 문제를 해결하려고 노력하며, 감정에 휘둘리지 않아요.
      세진은 예전에 당신을 도와준 적이 있어요.
      세진의 부탁을 거절할 때는 이유를 명확하게 설명하고, 대안을 제시하는 것이 중요해요.''',
      image: ImageAssets.char2,
      analyzePrompt: Prompt.sejinAnalyzePrompt,
    ),
    CharacterEntity(
      characterId: 3,
      name: '현아',
      type: '집요형',
      requestStrength: 3,
      prompt: Prompt.hyunaPrompt,
      description: '''현아는 틱톡 스타고 외향적인 성격이에요.☀️
      포기하지 않고 끈기 있게 부탁을 반복해요.
      처음엔 거절하는 이유를 설명하고 부드럽게 거절하지만, 정도가 강해지면 단호한 태도로 거절해야 해요.
      현아는 솔직하고 감정 표현이 풍부해요''',
      image: ImageAssets.char3,
      analyzePrompt: Prompt.hyunaAnalyzePrompt,
    ),
    CharacterEntity(
      characterId: 4,
      name: '진혁',
      type: '분노형',
      requestStrength: 4,
      prompt: Prompt.jinhyukPrompt,
      description: '''진혁은 단순하고 직설적인 성격으로, 감정 표현이 격렬하고 분노 조절을 잘 못해요.🔥
      진혁의 솔직하고 거침없는 성격 때문에 상처받는 친구가 많아요.
      진혁은 예전에 같은 반이어서 친해졌지만 최근에는 약간 멀어진 사이에요.
      진혁의 부탁을 거절할 때 우물쭈물 거절하면 진혁이 부탁을 반복할 수 있어요. ''',
      image: ImageAssets.char4,
      analyzePrompt: Prompt.jinhyukAnalyzePrompt,
    ),
  ];

  await characterDao.insertCharacters(characters);

  // 그룹 1: 자기 수용과 자존감
  final group1Data = [
    MindsetEntity(id: 1, group: 1, content: '모든 사람을 만족시킬 수는 없다.', reason: '모든 사람을 만족시키려 하면 자신을 잃게 됩니다. 스스로를 우선시하는 것이 중요합니다. 이는 우리의 정신적, 감정적 건강을 지키는 데 필요합니다.'),
    MindsetEntity(id: 2, group: 1, content: '모두가 처음에는 떨린다.', reason: '사람들 앞에서 말하는 것이 두렵다면, 모두가 처음에는 떨린다는 것을 기억하세요. 반복적인 연습과 작은 성공을 통해 자신감을 키울 수 있습니다.'),
    MindsetEntity(id: 3, group: 1, content: '자신의 강점을 찾자.', reason: '자신감을 키우기 위해서는 자신의 강점을 찾고 그것을 개발하는 것이 중요합니다. 이는 자기 효능감을 높이고 더 나은 자신을 만드는 데 도움이 됩니다.'),
    MindsetEntity(id: 4, group: 1, content: '실수는 누구나 한다.', reason: '실수는 성장의 과정 중 하나입니다. 실수를 통해 배우고 개선할 수 있습니다. 이를 받아들이면 더 나은 관계를 형성할 수 있습니다.'),
    MindsetEntity(id: 5, group: 1, content: '자신을 돌보는 시간을 가지자.', reason: '자신을 돌보는 것은 매우 중요합니다. 건강한 마음과 몸이 있어야 다른 사람들과의 관계도 건강하게 유지할 수 있습니다.'),
    MindsetEntity(id: 6, group: 1, content: '긍정적인 자기 대화를 하자.', reason: '긍정적인 자기 대화는 자신감을 높이고, 어려운 상황에서도 긍정적인 태도를 유지하는 데 도움이 됩니다. 이는 대인관계에서도 긍정적인 영향을 미칩니다.'),
    MindsetEntity(id: 7, group: 1, content: '자기 표현을 두려워하지 말자.', reason: '자신의 생각과 감정을 표현하는 것은 매우 중요합니다. 타인의 반응을 두려워하지 말고 솔직하게 자신을 표현하는 것이 필요합니다. 이는 진정한 나를 보여주고 관계를 깊게 만드는 데 도움이 됩니다.'),
    MindsetEntity(id: 8, group: 1, content: '타인의 시선은 나의 가치가 아니다.', reason: '타인의 시선과 평가가 나의 가치를 결정하지 않습니다. 나 자신의 가치와 자존감을 스스로 인정하는 것이 중요합니다. 이는 건강한 자아상을 유지하는 데 도움이 됩니다.'),
    MindsetEntity(id: 9, group: 1, content: '과거에 얽매이지 말자.', reason: '과거에 얽매여 현재의 불행한 관계를 유지하는 것은 도움이 되지 않습니다. 과거를 인정하고, 현재와 미래를 위해 필요한 결정을 내리는 것이 중요합니다.'),
    MindsetEntity(id: 10, group: 1, content: '나 자신을 있는 그대로 받아들이자.', reason: '내가 편안해야 상대방도 편안해집니다. 나 자신을 \'괜찮다\'고 인정하는 것이 중요합니다.'),
    MindsetEntity(id: 11, group: 1, content: '나의 편안함이 상대방에게 전해진다.', reason: '내가 편안한 마음을 가지면, 그 에너지가 상대방에게도 전달됩니다. 이는 자연스럽고 편안한 관계를 형성하는 데 도움이 됩니다.'),
    MindsetEntity(id: 12, group: 1, content: '타인의 생각은 그들의 문제다.', reason: '타인의 생각과 의견은 그들의 문제이며, 내가 통제할 수 없는 부분입니다. 나 자신의 감정과 생각에 집중하는 것이 더 중요합니다. 이는 나의 정신적 건강을 지키는 데 도움이 됩니다.'),
    MindsetEntity(id: 13, group: 1, content: '타인의 판단은 일시적이다.', reason: '타인의 판단은 일시적이고 변할 수 있습니다. 이에 너무 집착하지 말고 나 자신의 길을 가는 것이 중요합니다. 이는 지속적인 자아 발전과 행복을 추구하는 데 도움이 됩니다.'),
    MindsetEntity(id: 14, group: 1, content: '모두에게 좋은 인상을 줄 필요는 없다.', reason: '모든 사람에게 좋은 인상을 주려고 노력하면 지치게 됩니다. 자신에게 중요한 사람들과의 관계에 집중하는 것이 더 중요합니다. 이는 나의 에너지를 효율적으로 사용하는 데 도움이 됩니다.'),
    MindsetEntity(id: 15, group: 1, content: '나의 삶은 내가 결정한다.', reason: '나의 삶의 주인은 나 자신입니다. 타인의 의견에 휘둘리지 않고, 나의 결정을 스스로 내리는 것이 중요합니다. 이는 진정한 자유와 자아 존중을 이루는 데 도움이 됩니다.')
  ];

  // 그룹 2: 거절과 경계 설정
  final group2Data = [
    MindsetEntity(id: 16, group: 2, content: '거절은 나의 권리다.', reason: '우리는 자신의 시간과 에너지를 선택할 권리가 있습니다. 거절은 자신의 필요와 우선순위를 지키기 위한 정당한 선택입니다. 이를 통해 삶을 더 주도적으로 이끌 수 있습니다.'),
    MindsetEntity(id: 17, group: 2, content: '비난보다는 해결책을 찾자.', reason: '갈등 상황에서 상대방을 비난하기보다는 함께 해결책을 찾는 것이 중요합니다. 이는 문제를 더 효율적으로 해결하고 관계를 강화하는 데 도움이 됩니다.'),
    MindsetEntity(id: 18, group: 2, content: '모든 요청에 \'예\'라고 말할 필요는 없다.', reason: '모든 요청에 \'예\'라고 답하는 것은 나의 의지와 필요를 무시하게 만듭니다. 나의 한계를 알고 적절히 거절하는 것이 중요합니다. 이는 나의 자존감을 지키고 대인관계를 건강하게 유지하는 데 도움이 됩니다.'),
    MindsetEntity(id: 19, group: 2, content: '거절은 관계를 깨지 않는다.', reason: '올바르게 거절하는 것은 관계를 망치지 않습니다. 오히려, 솔직한 대화는 관계를 더욱 깊게 만들 수 있습니다. 서로의 한계를 존중하는 것이 중요합니다.'),
    MindsetEntity(id: 20, group: 2, content: '거절은 자신감의 표현이다.', reason: '거절할 줄 아는 것은 자신감의 표현입니다. 자신의 한계를 알고 그것을 표현하는 것이 진정한 용기입니다. 이는 타인에게 나의 경계를 명확히 알려주는 데 도움이 됩니다.'),
    MindsetEntity(id: 21, group: 2, content: '연습을 통해 거절 능력을 키우자.', reason: '거절하는 것은 연습을 통해 더욱 자연스러워질 수 있습니다. 작은 일에서부터 거절을 연습해보면, 점점 더 큰 일에서도 자연스럽게 거절할 수 있습니다. 이는 나의 의사결정 능력을 강화합니다.'),
    MindsetEntity(id: 22, group: 2, content: '미안해하지 말자.', reason: '정당한 이유로 거절했을 때 미안해하지 말자. 나의 한계를 지키는 것은 당연한 일입니다. 과도한 죄책감은 나를 힘들게 할 뿐입니다. 거절은 내가 나 자신을 존중하는 한 방법입니다.'),
    MindsetEntity(id: 23, group: 2, content: '건설적인 대안을 제시하자.', reason: '거절할 때, 가능한 대안을 제시하면 상대방도 거절을 더 쉽게 받아들일 수 있습니다. 이는 상대방에게 존중받고 있다는 느낌을 주고 관계를 긍정적으로 유지하는 데 도움이 됩니다.'),
    MindsetEntity(id: 24, group: 2, content: '자신의 감정을 우선시하자.', reason: '자신의 감정과 필요를 우선시하는 것은 건강한 자아존중감을 형성하는 데 중요합니다. 다른 사람의 기대에 맞추기 위해 자신을 희생하는 것은 장기적으로 건강하지 않습니다.'),
    MindsetEntity(id: 25, group: 2, content: '상대방도 거절을 이해할 수 있다.', reason: '대부분의 사람들은 거절에 대해 이해할 수 있습니다. 너무 걱정하지 말고 솔직하게 말하는 것이 좋습니다. 이는 오해를 줄이고 관계를 긍정적으로 유지하는 데 도움이 됩니다.'),
    MindsetEntity(id: 26, group: 2, content: '거절을 통해 나의 기준을 세우자.', reason: '거절은 나의 기준과 경계를 명확히 하는 방법입니다. 나의 가치와 원칙을 지키기 위해 거절하는 것이 필요합니다. 이는 타인에게 나의 경계를 알리는 데 중요합니다.')
  ];

  // 그룹 3: 대인관계와 상호작용
  final group3Data = [
    MindsetEntity(id: 27, group: 3, content: '친구의 입장에서 생각해보자.', reason: '친구와의 관계에서 서로의 입장을 이해하려고 노력하면 갈등을 줄이고 더 깊은 유대감을 형성할 수 있습니다. 이는 상대방의 감정을 존중하고, 공감하는 능력을 키우는 데 도움이 됩니다.'),
    MindsetEntity(id: 28, group: 3, content: '자신의 감정을 솔직하게 표현하자.', reason: '감정을 솔직하게 표현하면 상대방이 나의 상황과 감정을 더 잘 이해할 수 있습니다. 이는 오해를 줄이고, 신뢰를 쌓으며, 건강한 의사소통을 가능하게 합니다.'),
    MindsetEntity(id: 29, group: 3, content: '다양한 관점을 존중하자.', reason: '서로 다른 관점을 존중하면 더 넓은 시각을 가지게 됩니다. 이는 서로의 차이를 이해하고, 갈등을 줄이며, 풍부한 대화를 나누는 데 도움이 됩니다.'),
    MindsetEntity(id: 30, group: 3, content: '긍정적인 피드백을 주자.', reason: '긍정적인 피드백은 상대방의 자존감을 높이고, 더 나은 행동을 유도하는 데 효과적입니다. 이는 건강한 대인관계를 유지하고, 서로의 성장을 지원하는 데 중요합니다.'),
    MindsetEntity(id: 31, group: 3, content: '배려는 억지로 할 필요가 없다.', reason: '억지로 하는 배려는 나와 상대방 모두에게 부담이 됩니다. 자연스럽게 나오는 배려가 진정한 배려이며, 이는 서로를 더 편안하게 하고 관계를 긍정적으로 유지하는 데 도움이 됩니다.'),
    MindsetEntity(id: 32, group: 3, content: '타산적인 배려는 하지 말자.', reason: '타산적인 배려는 상대방을 조작하려는 의도가 담겨 있어 진정한 배려가 아닙니다. 이는 오히려 신뢰를 손상시킬 수 있습니다. 순수한 마음에서 우러나오는 배려가 중요합니다.'),
    MindsetEntity(id: 33, group: 3, content: '나와 상대방이 다르다는 사실을 인정하자.', reason: '사람마다 생각과 느낌이 다르다는 사실을 인정하면 상대방을 더 잘 이해할 수 있습니다. 이는 상대방의 감정을 존중하고, 불필요한 갈등을 피하는 데 도움이 됩니다.'),
    MindsetEntity(id: 34, group: 3, content: '상대방의 사정을 단정짓지 말자.', reason: '상대방의 상황을 충분히 이해하지 못한 상태에서 결론을 내리는 것은 잘못된 판단으로 이어질 수 있습니다. 이는 오해를 줄이고, 상대방을 더 잘 이해하려는 노력을 통해 건강한 관계를 유지하는 데 중요합니다.'),
    MindsetEntity(id: 35, group: 3, content: '조언보다는 공감을 우선하자.', reason: '조언은 때로는 상대방을 바꾸려는 시도로 받아들여질 수 있습니다. 반면, 공감은 상대방의 감정을 이해하고 존중하는 데 초점을 맞춥니다. 이는 서로의 감정을 더 깊이 이해하고 신뢰를 쌓는 데 도움이 됩니다.'),
    MindsetEntity(id: 36, group: 3, content: '상호 존중이 없는 관계는 유지할 필요가 없다.', reason: '상호 존중이 없는 관계는 나에게 해로울 뿐입니다. 존중과 이해가 기반이 되는 관계만을 유지하는 것이 중요합니다.')
  ];

  await mindsetDao.insertMindsets(group1Data);
  await mindsetDao.insertMindsets(group2Data);
  await mindsetDao.insertMindsets(group3Data);
}
