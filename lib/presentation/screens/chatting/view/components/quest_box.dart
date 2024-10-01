import 'package:flutter/material.dart';
import 'package:palink_v2/core/theme/app_colors.dart';

class QuestBox extends StatelessWidget {
  final String questText;

  const QuestBox({super.key, required this.questText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 0.0, right: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0), // 모서리를 약간 둥글게 변경
        gradient: const LinearGradient(
          colors: [Color(0xff6BB2FF), Color(0xff2A91FF)],
          begin: Alignment.topLeft,
          end: Alignment.topRight
        ),
        border: Border.all(
          color: Colors.grey, // 파란색 얇은 보더 추가
          width: 0.6,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
        children: [
          // '현재 퀘스트' 제목
          const Text(
            '현재 퀘스트',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6.0), // 제목과 내용 사이에 간격 추가
          // 퀘스트 내용
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // 아이콘과 텍스트를 가운데 정렬
            children: [
              const Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 16), // 체크 아이콘 추가
              const SizedBox(width: 1.0), // 아이콘과 텍스트 사이의 간격
              Flexible(
                // 텍스트를 유연하게 줄바꿈할 수 있도록 함
                child: Text(
                  questText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 2, // 최대 두 줄까지 표시
                  overflow: TextOverflow.ellipsis, // 텍스트가 길 경우 말줄임표 처리
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
