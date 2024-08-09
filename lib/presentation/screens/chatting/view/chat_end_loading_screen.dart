import 'package:flutter/material.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_end_loading_viewmodel.dart';
import 'package:sizing/sizing.dart';


class ChatEndLoadingView extends StatelessWidget {
  final ChatEndLoadingViewModel chatEndLoadingViewModel;

  const ChatEndLoadingView({super.key, required this.chatEndLoadingViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.2.sh),
          _buildProfileImage(),
          const SizedBox(height: 20),
          Center(
            child: Text(
              ".. 대화 분석 중 ..",
              style: textTheme().titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: '\n',
                children: <TextSpan>[
                  TextSpan(
                    // 여기에 랜덤으로 마인드셋 하나 가져오고 싶음.
                      text: chatEndLoadingViewModel.randomMindset?.content ?? '',
                      style: textTheme().titleMedium),
                  TextSpan(
                      text: chatEndLoadingViewModel.randomMindset?.reason ?? '',
                      style: textTheme().bodyMedium),
                ],
              ),
            ),
          ),
          const CircularProgressIndicator(color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 150,
      height: 150,
      child: Image.asset(chatEndLoadingViewModel.character.image), // 실제 이미지 경로로 수정 필요
    );
  }
}
