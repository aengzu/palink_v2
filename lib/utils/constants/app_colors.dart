import 'package:flutter/material.dart';

class AppColors {
  // 어플 컬러 관리
  static const Color lightBlue = Color(0xffCFE6FF);
  static const Color lightGray = Color(0xffF0F0F0);
  static const Color deepBlue = Color(0xff0156B0);
  static Color mediumBlue = Color(0xff004D9F).withOpacity(0.7); // 70% opacity
  static const Color pink = Color(0xffFE3287);

  // 배경화면 그라데이션
  static BoxDecoration buildGradientBoxDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
      colors: [Color(0xff6BB2FF), Color(0xff2A91FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
    ));
  }
}
