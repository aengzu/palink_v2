import 'package:flutter/material.dart';

class CustomQuestButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomQuestButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.0), // 클릭 효과를 위한 모서리 둥글기
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // 버튼 크기
        decoration: BoxDecoration(
          color: Colors.white, // 배경색
          border: Border.all(color: Colors.grey), // 회색 보더
          borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 8, // 텍스트 크기
            color: Colors.grey, // 텍스트 색상
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
