import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/entities/likability/liking_level.dart';
import 'chat_bubble.dart';

class Messages extends StatelessWidget {
  final List<LikingLevel> likingLevels;
  final List<Message> messages;
  final int userId;
  final String characterImg;
  final Function(Message, String) onReactionAdded;

  Messages({
    required this.likingLevels,
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
          final isSender = message.sender;

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
                          onReactionAdded: (Message msg, String reaction) {
                            onReactionAdded(message, reaction);
                          },
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
                onReactionAdded: (Message msg, String reaction) {
                  onReactionAdded(msg, reaction);
                },
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
