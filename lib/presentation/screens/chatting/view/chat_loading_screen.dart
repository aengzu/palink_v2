import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/usecase/get_message_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/send_message_usecase.dart';
import 'package:palink_v2/domain/usecase/start_conversation_usecase.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_loading_viewmodel.dart';
import 'package:sizing/sizing.dart';

class ChatLoadingScreen extends StatelessWidget {
  final Character character;

  // ChatLoadingViewModel 생성자 매개변수에 character를 전달
  ChatLoadingScreen({required this.character, Key? key})
      : viewModel = Get.put(ChatLoadingViewModel(
    startConversationUseCase: getIt<StartConversationUseCase>(),
    getMessagesUseCase: getIt<GetMessagesUseCase>(),
    sendMessageUseCase: getIt<SendMessageUseCase>(),
    getUserInfoUseCase: getIt<GetUserInfoUseCase>(),
    character: character, // 여기에 character를 전달
  )),
        super(key: key);

  final ChatLoadingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.2.sh),
          _buildProfileImage(),
          Center(
            child: Text(
              character.name,
              style: textTheme().titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
            child: _buildStyledDescription(character.description!),
          ),
          CircularProgressIndicator(color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: EdgeInsets.all(10),
      width: 150,
      height: 150,
      child: Image.asset(character.image),
    );
  }

  Widget _buildStyledDescription(String description) {
    List<String> lines = description.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            lines[0],
            style: textTheme().titleSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 8.0),
        RichText(
          text: TextSpan(
            style: textTheme().bodyMedium?.copyWith(height: 1.5),
            children: [
              for (var line in lines.skip(1))
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.only(right: 4.0, bottom: 2.0),
                        child: Icon(Icons.check_circle,
                            color: Colors.blue, size: 16),
                      ),
                    ),
                    TextSpan(text: line + '\n'),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
