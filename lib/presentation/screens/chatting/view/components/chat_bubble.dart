import 'package:flutter/material.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:sizing/sizing.dart';
import 'liking_bar.dart';

class ChatBubbles extends StatefulWidget {
  final Message message;
  final bool isSender;
  final String characterImg;
  final int affinityScore;

  ChatBubbles(this.message, this.isSender, this.characterImg, this.affinityScore);

  @override
  _ChatBubblesState createState() => _ChatBubblesState();
}

class _ChatBubblesState extends State<ChatBubbles> {
  OverlayEntry? _overlayEntry;

  void _showReactionMenu(BuildContext context, Offset offset) {
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _removeOverlay();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.transparent, // transparent background to detect taps outside the menu
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy - 50, // adjust the position as needed
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {
                          // 리액션 추가 로직
                          _removeOverlay();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          // 리액션 추가 로직
                          _removeOverlay();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.sentiment_satisfied),
                        onPressed: () {
                          // 리액션 추가 로직
                          _removeOverlay();
                        },
                      ),
                      // 다른 리액션들을 추가할 수 있습니다.
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!widget.isSender)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onLongPressStart: (details) {
                        _showReactionMenu(context, details.globalPosition);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5, right: 0.18.sw, left: 0.05.sw),
                        padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.011.sh),
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.message.messageText,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (widget.isSender)
          GestureDetector(
            onLongPressStart: (details) {
              _showReactionMenu(context, details.globalPosition);
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 5, right: 0.05.sw, left: 0.3.sw),
              padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.message.messageText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
      ],
    );
  }
}
