import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import '../../../constants/app_colors.dart';
import '../../../models/chat/message.dart';
import 'liking_bar.dart';

class ChatBubbles extends StatelessWidget {
  final Message message;
  final bool isSender;
  final String characterImg;
  final int affinityScore;  // 호감도 점수 추가

  ChatBubbles(this.message, this.isSender, this.characterImg, this.affinityScore);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isSender)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,  // 상단 정렬
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      backgroundImage: AssetImage(characterImg),
                    ),
                  ),
                  LikingBar(affinityScore)
                ],
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5, right: 0.18.sw, left: 0.05.sw),
                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.011.sh),
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message.messageText,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        if (isSender)
                Container(
                  margin: EdgeInsets.only(
                      top: 10, bottom: 5, right: 0.05.sw, left: 0.3.sw
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.01.sh),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    message.messageText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
      ],
    );
  }
}
