import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/widgets/stacked_reactions.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:sizing/sizing.dart';
import 'package:intl/intl.dart';
import 'liking_bar.dart';

class ChatBubbles extends StatefulWidget {
  final Message message;
  final bool isSender;
  final String characterImg;
  final int affinityScore;
  final Function(Message, String) onReactionAdded;

  ChatBubbles({
    required this.message,
    required this.isSender,
    required this.characterImg,
    required this.affinityScore,
    required this.onReactionAdded,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      backgroundImage: AssetImage(widget.characterImg),
                    ),
                  ),
                  LikingBar(widget.affinityScore),
                ],
              ),
              Flexible(
                child: Stack(
                  children: [
                   Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 5, right: 0.25.sw, left: 0.05.sw),
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
                                  style: textTheme().bodySmall,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      timeAgo(widget.message.timestamp),  // <-- 여기에 적용
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
                    top: 10, bottom: 5, right: 0.05.sw, left: 0.33.sw),
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
                      style: textTheme().bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          timeAgo(widget.message.timestamp),  // <-- 여기에 적용
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
}
