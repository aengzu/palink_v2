import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:palink_v2/controller/character_controller.dart';
import 'package:palink_v2/views/auth_view/login_view.dart';
import 'package:palink_v2/views/character_select_view/character_select_view.dart';
import 'package:palink_v2/views/chatting_view/chat_screen.dart';
import 'package:palink_v2/views/main_screens.dart';
import 'package:palink_v2/views/splash_view/splash_screen.dart';
import 'package:sizing/sizing.dart';

import 'constants/app_fonts.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
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
        home: LoginView(),
        ),
    );
  }
}
