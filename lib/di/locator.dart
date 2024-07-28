// locator.dart (GetIt 설정 파일)
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:palink_v2/data/repository/character_repositoryImpl.dart';
import 'package:palink_v2/data/repository/chat_repositoryImpl.dart';
import 'package:palink_v2/data/repository/user_repositoryImpl.dart';
import 'package:palink_v2/data/services/auth_service.dart';
import 'package:palink_v2/data/services/chat_service.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';
import 'package:palink_v2/domain/usecase/get_character_usecase.dart';
import 'package:palink_v2/domain/usecase/get_message_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_usecase.dart';
import 'package:palink_v2/domain/usecase/send_message_usecase.dart';
import 'package:palink_v2/domain/usecase/sign_up_usecase.dart';
import 'package:palink_v2/domain/usecase/start_conversation_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/controller/login_view_model.dart';
import 'package:palink_v2/presentation/screens/auth/controller/signup_view_model.dart';
import 'package:palink_v2/presentation/screens/character_select/controller/character_select_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/auth_repositoryImpl.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/usecase/login_usecase.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() async {
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

  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<Dio>()));
  getIt.registerLazySingleton<ChatService>(() => ChatService(getIt<Dio>()));

  // 리포지토리 등록
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthService>(), prefs));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt<ChatService>()));
  getIt.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl());


  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(loginUseCase: getIt<LoginUseCase>()));
  getIt.registerFactory<SignupViewModel>(() => SignupViewModel(signUpUseCase: getIt<SignUpUseCase>()));
  getIt.registerFactory<MypageViewmodel>(() => MypageViewmodel(getUserUseCase: getIt<GetUserUseCase>()));
  getIt.registerLazySingleton<CharacterSelectViewModel>(() => CharacterSelectViewModel(getCharactersUseCase: getIt<GetCharactersUseCase>()));
  getIt.registerFactory<StartConversationUseCase>(() => StartConversationUseCase(getIt<ChatRepository>(), getIt<GetUserInfoUseCase>()));


  getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<SignUpUseCase>(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<GetUserInfoUseCase>(() => GetUserInfoUseCase(getIt<UserRepository>()));
  getIt.registerFactory<GetMessagesUseCase>(() => GetMessagesUseCase(getIt<ChatRepository>()));
  getIt.registerFactory<GetUserUseCase>(() => GetUserUseCase(getIt<UserRepository>()));
  getIt.registerFactory<SendMessageUseCase>(() => SendMessageUseCase(getIt<ChatRepository>()));
  getIt.registerFactory<GetCharactersUseCase>(() => GetCharactersUseCase(getIt<CharacterRepository>()));
}
