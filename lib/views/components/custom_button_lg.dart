import 'package:flutter/material.dart';

class CustomButtonLG extends StatelessWidget {
  final String label;
  VoidCallback onPressed;

  CustomButtonLG({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 50.0, // 버튼의 높이 설정
      width: screenWidth * 0.8, // 화면 가로 크기의 80%에 해당하는 너비 설정

      decoration: BoxDecoration(// 그림자 설정
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // 그림자 색상 설정
              spreadRadius: 2, // 그림자 확산 정도
              blurRadius: 5, // 그림자의 흐림 정도
              offset: Offset(0, 3), // 그림자의 위치 (수평, 수직)
            ),
          ],
          borderRadius: BorderRadius.circular(10.0), // 버튼의 모서리를 둥글게 처리
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff3dadff), Color(0xff1986fc)], // 그라디언트 색상 설정
          )
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // 배경색을 투명하게 설정
            shadowColor: Colors.transparent, // 그림자 색상을 투명하게 설정
          ),
          onPressed: onPressed, // 버튼 클릭 이벤트 연결
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white, // 글자색을 흰색으로 설정
              fontSize: 20, // 글자 크기를 20으로 설정
            ),
          )
      ),
    );
  }
}
