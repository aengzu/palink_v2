import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/constants/app_images.dart';
import 'package:palink_v2/controller/splash_controller.dart';

import '../../constants/app_colors.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller 초기화
    final controller = Get.put(SplashController());
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: AppColors.buildGradientBoxDecoration(),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width:30.0),
                Image.asset(ImageAssets.logo, height: 300, width: 200),
              ],
            ),),
        ),
      );
  }
}
