import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/widgets/stacked_reactions.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:sizing/sizing.dart';
import 'package:intl/intl.dart';
import 'feeling_bar.dart';
import 'liking_bar.dart';

class ChatBubbles extends StatefulWidget {
  final Message message;
  final bool isSender;
  final String characterImg;
  final int affinityScore;
  final String feeling;
  final List<int> rejectionScore;
  final Function(Message, String) onReactionAdded;

  ChatBubbles({
    required this.message,
    required this.isSender,
    required this.characterImg,
    required this.affinityScore,
    required this.onReactionAdded,
    required this.feeling,
    required this.rejectionScore,
  });

  @override
  _ChatBubblesState createState() => _ChatBubblesState();
}

class _ChatBubblesState extends State<ChatBubbles> {
  // 날짜와 시간만 표시하는 함수
  String formatDateTime(String isoDate) {
    DateTime parsedDate = DateTime.parse(isoDate);
    // 원하는 형식으로 변환 (년-월-일 시간:분)
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
    return formattedDate;
  }

  // 상대적인 시간을 표시하는 함수 (예: "1분 전", "방금 전")
  String timeAgo(String isoDate) {
    DateTime messageTime = DateTime.parse(isoDate);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(messageTime);

    if (difference.inSeconds < 60) {
      return "방금 전";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}분 전";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}시간 전";
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(messageTime); // 날짜와 시간만 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!widget.isSender)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // 가로로 뒤집기
                front: Container(
                  margin: const EdgeInsets.only(left: 5.0, top: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    backgroundImage: AssetImage(widget.characterImg),
                  ),
                ),
                back: Container(
                  margin: const EdgeInsets.only(left: 5.0, top: 8.0),
                  width: 60, // CircleAvatar의 크기와 동일하게 설정
                  height: 60, // CircleAvatar의 크기와 동일하게 설정
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // 원형 모양을 유지
                    color: Color(0xffd8e9fc), // 배경색 설정
                  ),
                  alignment: Alignment.center, // 텍스트를 중앙에 배치
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '획득 거절점수', // 거절점수 총합 표시
                        style: textTheme().bodySmall?.copyWith(
                          color: Colors.black, // 텍스트 색상
                          fontWeight: FontWeight.bold,
                          fontSize: 8, // 텍스트 크기
                        ),
                      ),
                      Text(
                        '${calculateRejectionScoreSum()}', // 거절점수 총합 표시
                        style: textTheme().bodySmall?.copyWith(
                          color: Colors.indigo, // 텍스트 색상
                          fontWeight: FontWeight.bold,
                          fontSize: 10, // 텍스트 크기
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            right: 0.25.sw, left: 0.05.sw, top: 8.0, bottom: 8.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.011.sh),
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.message.messageText,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 13.0, color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    timeAgo(widget.message.timestamp),
                                    style: textTheme().bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontSize: 11,
                                        ),
                                  ),
                                ],
                              )
                            ])),
                    if (widget.message.reactions.isNotEmpty)
                      Positioned(
                        bottom: 4,
                        left: 20,
                        child: StackedReactions(
                          reactions: widget.message.reactions,
                          stackedValue: 4.0,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        if (widget.isSender)
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 0.05.sw, left: 0.33.sw),
                padding: EdgeInsets.symmetric(
                    horizontal: 0.05.sw, vertical: 0.01.sh),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message.messageText,
                      style: const TextStyle(
                        fontSize: 13.0, color: Colors.black,
                      )
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          timeAgo(widget.message.timestamp), // <-- 여기에 적용
                          style: textTheme().bodySmall?.copyWith(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
  // rejectionScore 총합을 계산하는 함수
  int calculateRejectionScoreSum() {
    return widget.rejectionScore.fold(0, (sum, score) => sum + score);
  }
}
