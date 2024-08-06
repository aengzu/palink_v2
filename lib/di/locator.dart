import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/api/auth_api.dart';
import 'package:palink_v2/data/api/chat_api.dart';
import 'package:palink_v2/data/repository/auth_repositoryImpl.dart';
import 'package:palink_v2/data/repository/character_repositoryImpl.dart';
import 'package:palink_v2/data/repository/chat_repositoryImpl.dart';
import 'package:palink_v2/data/repository/user_repositoryImpl.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';
import 'package:palink_v2/domain/repository/auth_repository.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';
import 'package:palink_v2/domain/usecase/create_conversation_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_characters_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_initial_message_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/domain/usecase/sign_up_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/controller/login_view_model.dart';
import 'package:palink_v2/presentation/screens/auth/controller/signup_view_model.dart';
import 'package:palink_v2/presentation/screens/character_select/controller/character_select_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/ai_repositoryImpl.dart';
import '../domain/usecase/generate_tip_usecase.dart'; // Import GenerateTipUsecase
import '../domain/usecase/login_usecase.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

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

  getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<Dio>()));
  getIt.registerLazySingleton<ChatApi>(() => ChatApi(getIt<Dio>()));

  // 리포지토리 등록
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthApi>(), prefs));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt<ChatApi>()));
  getIt.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl());

  // AI 의존성 등록
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
      당신은 USER 를 {userName}으로 부르세요. rejection_score는 누적되어야하고 만약 -5 이하면 is_end를 즉시 1로 설정하세요.
      다음은 당신에 대한 설명입니다.
      {description}
      답변으로 'text', 'feeling', 'expected_emotion', 'rejection_score', 'affinity_score', 'is_end'을 반드시 JSON 객체로 리턴하세요. ("```"로 시작하는 문자열을 생성하지 마세요)
      
      {chat_history}
      {userName}: {input}
      AI: 
    '''),
    outputKey: 'response',
    inputKey: 'input',
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
      'evaluation'은 사용자의 대화 능력을 AI의 입장에서 100자 이내로 평가한 문자열입니다.
      'used_rejection'은 사용자가 대화에서 '사용한 거절 능력(해당 능력의 점수)'의 목록을 나타냅니다. 아이템의 구분은 ',' 로 나타냅니다. 
      'final_rejction_score'은 총 거절 점수입니다.
    '''),
    llm: getIt<ChatOpenAI>(),
  ), instanceName: 'analyzeChain');

  // AI 리포지토리 등록
  getIt.registerLazySingleton<AIRepository>(() => AIRepositoryImpl(
    getIt<ChatOpenAI>(),
    getIt<ConversationBufferMemory>(),
    getIt<ConversationBufferMemory>(instanceName: 'tipMemory'),
    getIt<ConversationChain>(),
    getIt<LLMChain>(),
    getIt<LLMChain>(instanceName: 'analyzeChain'),
  ));

  // Use Cases 등록
  getIt.registerFactory<CreateConversationUseCase>(() => CreateConversationUseCase(getIt<ChatRepository>(), getIt<GetUserInfoUseCase>()));
  getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<SignUpUseCase>(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<GetUserInfoUseCase>(() => GetUserInfoUseCase(getIt<UserRepository>()));
  getIt.registerFactory<GetUserUseCase>(() => GetUserUseCase(getIt<UserRepository>()));
  getIt.registerFactory<FetchCharactersUsecase>(() => FetchCharactersUsecase(getIt<CharacterRepository>()));
  getIt.registerFactory<GenerateInitialMessageUsecase>(() => GenerateInitialMessageUsecase());
  getIt.registerFactory<FetchChatHistoryUsecase>(() => FetchChatHistoryUsecase(getIt<ChatRepository>()));
  getIt.registerFactory<SendUserMessageUsecase>(() => SendUserMessageUsecase(getIt<ChatRepository>(), getIt<GenerateResponseUsecase>()));
  getIt.registerFactory<GenerateResponseUsecase>(() => GenerateResponseUsecase(getIt<GetUserInfoUseCase>(), getIt<FetchChatHistoryUsecase>()));
  getIt.registerFactory<GenerateTipUsecase>(() => GenerateTipUsecase());

  // 뷰모델 등록
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(loginUseCase: getIt<LoginUseCase>()));
  getIt.registerFactory<SignupViewModel>(() => SignupViewModel(signUpUseCase: getIt<SignUpUseCase>()));
  getIt.registerFactory<MypageViewModel>(() => MypageViewModel(getUserUseCase: getIt<GetUserUseCase>()));
  getIt.registerLazySingleton<CharacterSelectViewModel>(() => CharacterSelectViewModel(fetchCharactersUsecase: getIt<FetchCharactersUsecase>()));
  getIt.registerFactory<TipViewModel>(() => TipViewModel());
}
