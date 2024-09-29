import 'package:flutter/material.dart';

class FeelingBar extends StatelessWidget {
  final String feeling;

  FeelingBar({super.key, required this.feeling});

  @override
  Widget build(BuildContext context) {
    // 감정 문자열을 파싱하여 감정과 비율 목록으로 변환
    final feelingsList = _parseFeelingString(feeling);

    return Container(
      width: 68, // 고정된 너비 설정
      margin: const EdgeInsets.only(bottom: 10, top: 4, left: 5),
      child: Text(
        feelingsList.map((feelingData) {
          final feelingType = feelingData['type'] as String;
          final feelingPercentage = feelingData['percentage'] as int;
          return '$feelingType $feelingPercentage%';
        }).join(', '),
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 9, // 작은 글씨 크기 설정
        ),
        textAlign: TextAlign.center, // 텍스트를 수평 중앙 정렬
      ),
    );
  }

  // 감정 문자열 파싱을 위한 헬퍼 함수
  List<Map<String, dynamic>> _parseFeelingString(String feelingString) {
    final feelings = feelingString.split(',').map((feeling) {
      final parts = feeling.trim().split(' ');
      return {
        'type': parts[0],
        'percentage': int.parse(parts[1]),
      };
    }).toList();

    return feelings;
  }
}
