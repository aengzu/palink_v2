import 'package:flutter/material.dart';

class CustomChatInput extends StatelessWidget {
  final bool isVisible;
  final Function(String) onSendPressed;
  final TextEditingController _controller = TextEditingController();

  CustomChatInput({required this.isVisible, required this.onSendPressed});

  @override
  Widget build(BuildContext context) {
    if (!isVisible)
      return Container(); // Return an empty container if not visible

    return Container(
      margin: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 20.0, bottom: 40.0),
      // Add some margin around the container
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(24.0), // Rounded corners
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0), // Add vertical padding
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  onSendPressed(text);
                  _controller.clear();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              String text = _controller.text;
              if (text.isNotEmpty) {
                onSendPressed(text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
