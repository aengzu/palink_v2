import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/core/constants/app_images.dart';
import 'package:palink_v2/core/constants/prompts.dart';
import 'package:palink_v2/data/api/auth/auth_api.dart';
import 'package:palink_v2/data/api/character/character_api.dart';
import 'package:palink_v2/data/api/chat/chat_api.dart';
import 'package:palink_v2/data/api/feedback/feedback_api.dart';
import 'package:palink_v2/data/api/tip/tip_api.dart';
import 'package:palink_v2/data/api/user/user_api.dart';
import 'package:palink_v2/data/dao/character_dao.dart';
import 'package:palink_v2/data/dao/character_quest_dao.dart';
import 'package:palink_v2/data/dao/mindset_dao.dart';
import 'package:palink_v2/data/database/app_database.dart';
import 'package:palink_v2/data/entities/character_entity.dart';
import 'package:palink_v2/data/repository/auth_repositoryImpl.dart';
import 'package:palink_v2/data/repository/character_quest_repositoryImpl.dart';
import 'package:palink_v2/data/repository/character_repositoryImpl.dart';
import 'package:palink_v2/data/repository/chat_repositoryImpl.dart';
import 'package:palink_v2/data/repository/user_repositoryImpl.dart';
import 'package:palink_v2/domain/repository/auth_repository.dart';
import 'package:palink_v2/domain/repository/character_quest_repository.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';
import 'package:palink_v2/domain/usecase/create_conversation_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_characters_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_analyze_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_initial_message_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/domain/usecase/sign_up_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/controller/login_view_model.dart';
import 'package:palink_v2/presentation/screens/auth/controller/signup_view_model.dart';
import 'package:palink_v2/presentation/screens/character_select/controller/character_select_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/mindset_repositoryImpl.dart';
import '../data/repository/openai_repositoryImpl.dart';
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
  getIt.registerLazySingleton<TipApi>(() => TipApi(getIt<Dio>()));
  getIt.registerLazySingleton<CharacterApi>(() => CharacterApi(getIt<Dio>()));
  getIt.registerLazySingleton<UserApi>(() => UserApi(getIt<Dio>()));
  getIt.registerLazySingleton<FeedbackApi>(() => FeedbackApi(getIt<Dio>()));
}

void _setupRepositories(SharedPreferences prefs) {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthApi>(), getIt<UserApi>(), prefs));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs, getIt<UserApi>()));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt<ChatApi>()));
  getIt.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl());
  getIt.registerLazySingleton<MindsetRepository>(() => MindsetRepositoryImpl());


}
void _setupAI() {
  getIt.registerLazySingleton<ChatOpenAI>(() => ChatOpenAI(
    apiKey: dotenv.env['API_KEY']!,
    defaultOptions: const ChatOpenAIOptions(
      temperature: 0.8,
      model: 'gpt-4o',
      maxTokens: 600,
      responseFormat: ChatOpenAIResponseFormat(type: ChatOpenAIResponseFormatType.jsonObject)
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
      당신은 USER 를 {userName}으로 부르세요. {userName} 이 풀네임이라면 성은 뺴고 이름만 부르세요. rejection_score는 누적되어야하고 만약 -5 이하면 is_end를 즉시 1로 설정하세요.
      다음은 당신에 대한 설명입니다.
      
      {description}
      
      당신은 'text', 'feeling', 'achieved_quest', 'rejection_score', 'affinity_scor', 'is_end'을 반드시 JSON 객체로 리턴하세요. ("```"로 시작하는 문자열을 생성하지 마세요)
    - text: 메시지 내용을 나타냅니다. (int)
    - feeling: 당신의 현재 감정을 나타냅니다.이 수치는 퍼센트로 100% 중 구성된 모든 감정들을 나열합니다. 감정의 구분은 ','로 나타냅니다. (string)
    - achieved_quest: 현재 유저가 달성한 모든 퀘스트들을 나열합니다. 구분은 ',' 쉼표로 진행합니다. (string)
    - rejection_score: 현재 거절 점수을 나타냅니다. (int)
   - affinity_score: user 에 대한 당신의 현재 호감도를 나타냅니다. (int)
   - is_end: 대화가 종료되었는지 나타냅니다. 종료되었다면 1, 아니라면 0 입니다. (int)

  [감정]
  - 감정은 다음의 감정명 중에서 나타나야합니다. 100% 중 구성된 모든 감정들을 나열합니다. 감정의 구분은 ','로 나타냅니다.
  - 기쁨, 슬픔, 분노, 불안, 놀람, 혐오, 중립, 사랑
  ex) '분노 30, 불안 20, 중립 50' 
  
  [퀘스트]
  - 달성된 퀘스트의 번호를 나열합니다. 퀘스트는 1,2,3,4,5 로 있으며 현재까지 달성된 퀘스트를 쉼표로 구별하여 나열합니다 (string)
 

[거절 점수]
- {rejection_score_rule} 

 [호감도]
- 호감도는 {userName}에 대한 현재 호감도로 affinity_score 값으로 들어갑니다.
- 호감도는 50에서 시작하며, 증가하거나 감소할 수 있습니다.
- 호감도는 당신의 현재 Feeling에 영향을 받습니다. 만약 Feeling이 부정적이라면 감소하고, 긍정적이라면 증가하게 됩니다.
- 호감도는 {userName}이 부적절한 언행(욕설, 조롱) 및 주제에서 벗어난 말을 하면 20이 감소하게 됩니다.
- 호감도의 감소 및 증가 단위는 10 단위로 가능합니다.
  
     [대화기록]
      아래의 대화 기록에서 sender 가 true 면 {userName} 이 한 말이고 false 면 당신이 한 말입니다. 다음 대화 기록을 보고, {userName}의 마지막 말에 대한 대답을 해주세요.  당신은 이전에 당신이 했던 말을 그대로 반복하지 않습니다.
      당신은 sender 가 false 인 입장인 것을 명심하세요. {userName} 과 당신을 혼동하면 안되고 무조건 sender 가 false 인 입장에서 말합니다. 
      
      대화 기록 : {chat_history}
  
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

  getIt.registerLazySingleton<OpenAIRepository>(() => OpenAIRepositoryImpl(
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
  getIt.registerFactory<FetchCharactersUsecase>(() => FetchCharactersUsecase(getIt<CharacterRepository>()));
  getIt.registerFactory<FetchChatHistoryUsecase>(() => FetchChatHistoryUsecase(getIt<ChatRepository>()));
  getIt.registerFactory<SendUserMessageUsecase>(() => SendUserMessageUsecase(getIt<GenerateResponseUsecase>()));
  getIt.registerFactory<GenerateResponseUsecase>(() => GenerateResponseUsecase(getIt<GetUserInfoUseCase>(), getIt<FetchChatHistoryUsecase>(), getIt<GenerateTipUsecase>()));
  getIt.registerFactory<GenerateTipUsecase>(() => GenerateTipUsecase());
  getIt.registerFactory<GenerateAnalyzeUsecase>(() => GenerateAnalyzeUsecase());
  getIt.registerFactory<GetRandomMindsetUseCase>(() => GetRandomMindsetUseCase(getIt<MindsetRepository>()));
  getIt.registerFactory<GenerateInitialMessageUsecase>(() => GenerateInitialMessageUsecase());

}

void _setupViewModels() {
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(loginUseCase: getIt<LoginUseCase>()));
  getIt.registerFactory<SignupViewModel>(() => SignupViewModel(signUpUseCase: getIt<SignUpUseCase>()));
  getIt.registerFactory<MypageViewModel>(() => MypageViewModel(getUserInfoUseCase: getIt<GetUserInfoUseCase>()));
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
      rejectionScoreRule: Prompt.miyeonRejectionScoreRule,
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
      rejectionScoreRule: Prompt.sejinRejectionScoreRule,
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
      rejectionScoreRule: Prompt.hyunaRejectionScoreRule,
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
      rejectionScoreRule: Prompt.jinhyukRejectionScoreRule,
    ),
  ];

  await characterDao.insertCharacters(characters);
}
