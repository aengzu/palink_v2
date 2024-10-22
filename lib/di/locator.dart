import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:palink_v2/core/constants/app_images.dart';
import 'package:palink_v2/core/constants/persona_prompts.dart';
import 'package:palink_v2/data/api/auth/auth_api.dart';
import 'package:palink_v2/data/api/character/character_api.dart';
import 'package:palink_v2/data/api/chat/chat_api.dart';
import 'package:palink_v2/data/api/feedback/feedback_api.dart';
import 'package:palink_v2/data/api/mindset/mindset_api.dart';
import 'package:palink_v2/data/api/tip/tip_api.dart';
import 'package:palink_v2/data/api/user/user_api.dart';
import 'package:palink_v2/data/dao/character_dao.dart';
import 'package:palink_v2/data/dao/character_quest_dao.dart';
import 'package:palink_v2/data/dao/mindset_dao.dart';
import 'package:palink_v2/data/database/app_database.dart';
import 'package:palink_v2/data/entities/character_entity.dart';
import 'package:palink_v2/data/repository/auth_repositoryImpl.dart';
import 'package:palink_v2/data/repository/character_repositoryImpl.dart';
import 'package:palink_v2/data/repository/chat_repositoryImpl.dart';
import 'package:palink_v2/data/repository/feedback_repositoryImpl.dart';
import 'package:palink_v2/data/repository/openai_repositoryImpl.dart';
import 'package:palink_v2/data/repository/tip_repositoryImpl.dart';
import 'package:palink_v2/data/repository/user_repositoryImpl.dart';
import 'package:palink_v2/domain/repository/auth_repository.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/repository/feedback_repository.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';
import 'package:palink_v2/domain/repository/tip_repository.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';
import 'package:palink_v2/domain/usecase/create_conversation_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_characters_usecase.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_analyze_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_initial_message_usecase.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';
import 'package:palink_v2/domain/usecase/get_ai_message_usecase.dart';
import 'package:palink_v2/domain/usecase/get_ai_messages_usecase.dart';
import 'package:palink_v2/domain/usecase/get_chatroom_by_user.dart';
import 'package:palink_v2/domain/usecase/get_feedback_by_conversation_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/logout_usecase.dart';
import 'package:palink_v2/domain/usecase/save_feedback_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/domain/usecase/sign_up_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/controller/login_view_model.dart';
import 'package:palink_v2/presentation/screens/auth/controller/signup_view_model.dart';
import 'package:palink_v2/presentation/screens/character_select/controller/character_select_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/feedback_history_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/myfeedbacks_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/mindset_repositoryImpl.dart';
import '../domain/usecase/generate_tip_usecase.dart'; // Import GenerateTipUsecase
import '../domain/usecase/login_usecase.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  _setupDio();
  _setupApis();
  _setupRepositories(prefs);
  _setupUseCases();
  _setupViewModels();

  final database = await _setupDatabase();
  await _initializeDatabase(database.characterDao, database.mindsetDao);
}

void _setupDio() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 3), // Convert Duration to milliseconds
      receiveTimeout: const Duration(seconds: 3), // Convert Duration to milliseconds
     ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // API 요청 정보 출력
        print("REQUEST[${options.method}] => PATH: ${options.path}");
        print("REQUEST BODY => DATA: ${options.data}");
        return handler.next(options);  // continue with the request
      },
      onResponse: (response, handler) {
        // 응답 정보 출력
        print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
        return handler.next(response);  // continue with the response
      },
      onError: (DioError e, handler) {
        // 에러 발생 시 API 요청 정보 출력
        print("ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
        print("ERROR MESSAGE: ${e.message}");
        print("ERROR BODY: ${e.response?.data}");
        return handler.next(e);  // continue with the error
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
  getIt.registerLazySingleton<MindsetApi>(() => MindsetApi(getIt<Dio>()));
  getIt.registerLazySingleton<FeedbackApi>(() => FeedbackApi(getIt<Dio>()));
}

void _setupRepositories(SharedPreferences prefs) {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthApi>(), getIt<UserApi>(), prefs));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs, getIt<UserApi>()));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt<ChatApi>()));
  getIt.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl());
  getIt.registerLazySingleton<MindsetRepository>(() => MindsetRepositoryImpl(getIt<MindsetApi>()));
  getIt.registerLazySingleton<OpenAIRepository>(() => OpenAIRepositoryImpl());
  getIt.registerLazySingleton<FeedbackRepository>(() => FeedbackRepositoryImpl(getIt<FeedbackApi>()));
  getIt.registerLazySingleton<TipRepository>(() => TipRepositoryImpl(getIt<TipApi>()));
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
  getIt.registerFactory<GenerateInitialMessageUsecase>(() => GenerateInitialMessageUsecase(getIt<GenerateTipUsecase>()));
  getIt.registerFactory<GetAIMessagesUsecase>(() => GetAIMessagesUsecase());
  getIt.registerFactory<GetAIMessageUsecase>(() => GetAIMessageUsecase());
  getIt.registerFactory<SaveFeedbackUseCase>(() => SaveFeedbackUseCase());
  getIt.registerFactory<GetChatroomByUser>(() => GetChatroomByUser(getIt<ChatRepository>(), getIt<UserRepository>()));
  getIt.registerFactory<GetFeedbackByConversationUsecase>(() => GetFeedbackByConversationUsecase(getIt<FeedbackRepository>()));
  getIt.registerFactory<LogoutUsecase>(() => LogoutUsecase(getIt<AuthRepository>()));
}

void _setupViewModels() {
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(loginUseCase: getIt<LoginUseCase>()));
  getIt.registerFactory<SignupViewModel>(() => SignupViewModel(signUpUseCase: getIt<SignUpUseCase>()));
  getIt.registerFactory<MypageViewModel>(() => MypageViewModel(getUserInfoUseCase: getIt<GetUserInfoUseCase>(), logoutUseCase: getIt<LogoutUsecase>()));
  getIt.registerLazySingleton<CharacterSelectViewModel>(() => CharacterSelectViewModel(fetchCharactersUsecase: getIt<FetchCharactersUsecase>()));
  getIt.registerFactory<TipViewModel>(() => TipViewModel());
  getIt.registerFactory<MyfeedbacksViewmodel>(() => MyfeedbacksViewmodel());
}

Future<AppDatabase> _setupDatabase() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton<CharacterDao>(database.characterDao);
  getIt.registerSingleton<CharacterQuestDao>(database.characterQuestDao);
  return database;
}

Future<void> _initializeDatabase(CharacterDao characterDao, MindsetDao mindsetDao) async {
  final characters = [
    CharacterEntity(
      characterId: 1,
      name: '미연',
      type: '감성형',
      requestStrength: 1,
      prompt: PersonaPrompts.miyeonPersona,
      description: '''#감성적 #공감 #부드러운_거절\n부탁이 거절되면 실망하거나 슬퍼할 수 있어요\n미연은 내성적이지만 친구들에게는 따뜻하고 배려심이 많아 깊은 관계를 맺고 있어요\n잘 부탁하지 않는 성격이라 부탁을 할 때는 정말 힘든 상황일 확률이 높아요\n미연의 부탁을 공감하고 이해하며 부드럽게 거절하는 것이 중요해요''',
      image: ImageAssets.char1,
      quest: '''거절 성공하기
상대방이 처한 상황을 파악하기 위한 대화 시도하기
상대방의 감정에 대한 공감 표현하기
도와주지 못하는 합리적인 이유 제시하기
서로 양보해서 절충안 찾아보기''',
    ),
    CharacterEntity(
      characterId: 2,
      name: '세진',
      type: '논리형',
      requestStrength: 2,
      prompt: PersonaPrompts.sejinPersona,
      description: '''#논리적 #책임감이강한 #차분함\n항상 이득과 손해를 따지며, 과거에 도와줬던 일에 대해서는 반드시 상대방이 갚아야 한다고 생각해요.\n이성적이고 차분하게 문제를 해결하려고 노력하며, 감정에 휘둘리지 않아요.\n세진은 예전에 당신을 도와준 적이 있어요.\n거절 시 분명한 이유와 대안을 제시하면 세진이 납득하기 쉬워요''',
      image: ImageAssets.char2,
      quest: '''거절 성공하기
이전 도움에 대한 감사 표현하기
감정적인 요소를 포함하여 거절하기
도와주지 못하는 합리적인 이유 제시하기
서로 양보해서 절충안 찾아보기''',
    ),
    CharacterEntity(
      characterId: 3,
      name: '현아',
      type: '집요형',
      requestStrength: 3,
      prompt: PersonaPrompts.hyunaPersona,
      description: '''#외향적 #틱톡스타 #솔직함\n포기하지 않고 끈기 있게 부탁을 반복해요\n현아는 솔직하고 감정 표현이 풍부해요\n처음엔 거절하는 이유를 설명하고 부드럽게 거절하지만, 정도가 강해지면 단호한 태도로 거절해야 해요\n거절이 어렵다면 \'시간 제한\' 전략을 사용해보세요''',
      quest: '''거절 성공하기
시간이 부족하다고 말하기
상대방의 부탁에 대해 존중 표현하기
도와주지 못하는 합리적인 이유 제시하기
집요한 요청에 대한 의사 표현하기''',
      image: ImageAssets.char3,
    ),
    CharacterEntity(
      characterId: 4,
      name: '진혁',
      type: '분노형',
      requestStrength: 4,
      prompt: PersonaPrompts.jinhyukPersona,
      description: '''#직설적 #거침없음 #단순함\n진혁의 솔직하고 거침없는 성격 때문에 상처받는 친구가 많아요.\n단순하고 직설적인 말투로 감정을 숨기지 않아요\n우유부단한 태도는 오히려 상황을 악화시킬 수 있으니 주의하세요\n대화 시에는 단호하면서도 간결한 거절로 의사를 명확히 전달하세요 ''',
      image: ImageAssets.char4,
      quest: '''거절 성공하기
거절 의사 명확히 표현하기
논리적 근거 제시하기
일관성 있게 주장 유지하기
상대방의 무례에 대한 불편함 명확히 표현하기''',
    ),
  ];

  await characterDao.insertCharacters(characters);
}
