import 'package:flutter/material.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability/liking_level.dart';

import 'chat_bubble.dart';


class Messages extends StatelessWidget {
  final List<LikingLevel> likingLevels;
  final List<Message> messages;
  final int userId;
  final String characterImg; // 캐릭터 이미지 추가

  Messages({
    required this.likingLevels,
    required this.messages,
    required this.userId,
    required this.characterImg, // 캐릭터 이미지 추가
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      child: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];

          // Check if likingLevels has an entry for the current message index
          int like = 50;
          if (index < likingLevels.length &&
              likingLevels[index].messageId == message.messageId) {
            like = likingLevels[index].likingLevel;
          }

          final isSender = message.sender;
          return ChatBubbles(
            message,
            isSender,
            characterImg, // 캐릭터 이미지 전달
            like, // 호감도 점수 전달
          );
        },
      ),
    );
  }
}
