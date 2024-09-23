import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
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
            child: Text(
              chatEndLoadingViewModel.mindset.mindsetText,
              style: textTheme().bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SpinKitThreeBounce(color: AppColors.deepBlue, size: 30),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 150,
      height: 150,
      child: Image.asset(
          chatEndLoadingViewModel.character.image), // 실제 이미지 경로로 수정 필요
    );
  }
}
