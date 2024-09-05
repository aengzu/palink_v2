import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/widgets/stacked_reactions.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:sizing/sizing.dart';
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
                                overflow: TextOverflow.ellipsis,
                                style: textTheme().bodySmall,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.message.timestamp,
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
                    top: 10, bottom: 5, right: 0.05.sw, left: 0.3.sw),
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
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.message.timestamp,
                          style: textTheme().bodySmall?.copyWith(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.message.reactions.isNotEmpty)
                Positioned(
                  bottom: 4,
                  right: 20,
                  child: StackedReactions(
                    reactions: widget.message.reactions,
                    stackedValue: 4.0,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
