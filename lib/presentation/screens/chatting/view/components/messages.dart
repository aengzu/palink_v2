import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'chat_bubble.dart';

class Messages extends StatelessWidget {
  final List<Message> messages;
  final int userId;
  final String characterImg;
  final Function(Message, String) onReactionAdded;

  Messages({
    required this.messages,
    required this.userId,
    required this.characterImg,
    required this.onReactionAdded,
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
          final like = messages[index].affinityScore;
          final feeling = messages[index].feeling;
          // 첫 번째 메시지인 경우, sender가 true여도 왼쪽에 배치
          final bool isFirstMessage = index == messages.length - 1;
          final isSender = isFirstMessage ? false : message.sender;
          final rejectionScore = messages[index].rejectionScore;

          return GestureDetector(
            onLongPress: () {
              Navigator.of(context).push(
                HeroDialogRoute(builder: (context) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: ReactionsDialogWidget(
                        id: message.id.toString(),
                        messageWidget: ChatBubbles(
                          message: message,
                          isSender: isSender,
                          characterImg: characterImg,
                          affinityScore: like,
                          feeling: feeling ?? '중립 100',
                          onReactionAdded: (Message msg, String reaction) {
                            onReactionAdded(message, reaction);
                          },
                          rejectionScore: rejectionScore
                        ),
                        onReactionTap: (reaction) {
                          if (reaction == '➕') {
                            // 이모지 선택기 표시
                          } else {
                            addReactionToMessage(
                              message: message,
                              reaction: reaction,
                            );
                          }
                        },
                        onContextMenuTap: (menuItem) {
                          print('menu item: $menuItem');
                        }
                        ),
                  );
                }),
              );
            },
            child: Hero(
              tag: message.id,
              child: ChatBubbles(
                message: message,
                isSender: isSender,
                characterImg: characterImg,
                affinityScore: like,
                feeling: feeling ?? '중립 100',
                onReactionAdded: (Message msg, String reaction) {
                  onReactionAdded(msg, reaction);
                },
                rejectionScore: rejectionScore,
              ),
            ),
          );
        },
      ),
    );
  }

  void addReactionToMessage({
    required Message message,
    required String reaction,
  }) {
    message.reactions.add(reaction);
  }
}
