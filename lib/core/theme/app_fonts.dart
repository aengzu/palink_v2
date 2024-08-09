import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// NOTE: 어플의 테마, 폰트를 관리합니다

// 앱의 전반적인 테마를 정의
ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    appBarTheme: appTheme(),
    primaryColor: Colors.green,
  );
}

// AppBarTheme 정의
AppBarTheme appTheme() {
  return AppBarTheme(
      centerTitle: false,
      color: Colors.white,
      elevation: 0.0,
      titleTextStyle: textTheme().titleMedium);
}

// 사용자 정의 폰트 (Noto Sans Korean)
TextTheme textTheme() {
  return const TextTheme(
    // DisplayLarge 텍스트 스타일. 기본 버튼
    // displayLarge: TextStyle(fontFamily: 'NotoSansKR', fontSize: 24, color: Colors.white),
    // 기본 버튼
    displayMedium: TextStyle(
        fontFamily: 'NotoSansKR',
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w300),
    // 미니 버튼
    displaySmall: TextStyle(
        fontFamily: 'NotoSansKR',
        fontSize: 13,
        color: Colors.white,
        fontWeight: FontWeight.w400),
    // BodyLarge 텍스트 스타일.
    bodyLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.w400,
      fontSize: 20.0,
      color: Colors.black,
    ),
    // BodyMedium 텍스트 스타일.
    bodyMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.w400,
      fontSize: 17.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.w400,
      fontSize: 13.0,
      color: Colors.black,
    ),
    // TitleLarge 텍스트 스타일.
    titleSmall: TextStyle(
        fontFamily: 'NotoSansKR',
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: 'NotoSansKR',
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontFamily: 'NotoSansKR',
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold),
  );
}
