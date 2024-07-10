import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class CustomChatTheme extends DefaultChatTheme {
  const CustomChatTheme()
      : super(
          primaryColor: Colors.blue,
          // Color for sent messages
          secondaryColor: const Color(0xffF0F0F0),
          // Very light gray color for received messages
          sentMessageBodyTextStyle: const TextStyle(
            color: Colors.white, // Text color for sent messages
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          receivedMessageBodyTextStyle: const TextStyle(
            color: Colors.black, // Text color for received messages
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        );
}
