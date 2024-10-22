import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:palink_v2/domain/model/user/user.dart';
import 'package:palink_v2/domain/usecase/login_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/view/login_view.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_sample.dart';
import 'package:palink_v2/presentation/screens/chatting/view/quest_sample.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';
import 'package:sizing/sizing.dart';

import 'di/locator.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/config/.env");
  await setupLocator(); // await 추가
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      builder: () => GetMaterialApp(
        color: Colors.white,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // 초기 경로를 '/'로 설정
        getPages: [
          GetPage(name: '/', page: () => _initialScreen()), // 초기 경로 설정
          GetPage(name: '/login', page: () => LoginView()), // 로그인 화면 경로
          GetPage(name: '/main', page: () => const MainScreens()), // 메인 화면 경로
          GetPage(name: '/chat', page: () => ChatSample()), // 채팅 화면 경로
          GetPage(name: '/quest', page: () => QuestSample()), // 퀘스트 화면 경로
        ],
      ),
    );
  }

  // 초기 화면 결정 함수 (자동 로그인 체크)
  Widget _initialScreen() {
    return FutureBuilder<User?>(
      future: _checkAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          return const MainScreens(); // 자동 로그인 성공 시 메인 화면으로 이동
        } else {
          return LoginView(); // 자동 로그인 실패 시 로그인 화면으로 이동
        }
      },
    );
  }

  // 자동 로그인 체크 함수
  Future<User?> _checkAutoLogin() async {
    final loginUseCase = GetIt.instance<LoginUseCase>();
    return await loginUseCase.checkAutoLogin();
  }
}
