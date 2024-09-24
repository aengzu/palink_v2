import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:palink_v2/domain/model/user/user.dart';
import 'package:palink_v2/domain/usecase/login_usecase.dart';
import 'package:palink_v2/presentation/screens/auth/view/login_view.dart';
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
        home: FutureBuilder(
          future: _checkAutoLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              return const MainScreens(); // 로그인된 상태라면 홈 화면으로 이동
            } else {
              return LoginView(); // 로그인되지 않은 상태라면 로그인 화면으로 이동
            }
          },
        ),
      ),
    );
  }

  Future<User?> _checkAutoLogin() async {
    final loginUseCase = GetIt.instance<LoginUseCase>();
    return await loginUseCase.checkAutoLogin();
  }
}
