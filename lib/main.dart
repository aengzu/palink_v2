import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:palink_v2/presentation/screens/auth/view/login_view.dart';
import 'package:sizing/sizing.dart';

import 'di/locator.dart';


Future<void> main() async {
  await dotenv.load(fileName: "lib/config/.env");
  setupLocator();
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
