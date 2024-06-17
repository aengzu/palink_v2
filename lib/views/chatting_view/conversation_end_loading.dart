import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/models/character.dart';
import 'package:sizing/sizing.dart';

import '../../constants/app_fonts.dart';
import '../../controller/conversation_end_controller.dart';

class ConversationEndLoadingView extends StatelessWidget {
  final ConversationEndController controller;

  ConversationEndLoadingView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.2.sh),
          _buildProfileImage(),
          SizedBox(height: 20),
          Center(
            child: Text(
              ".. 대화 분석 중 ..",
              style: textTheme().titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
            child: Text(
              "현실적으로 생각해도 못하겠으면 빨리 거절해야 상대방이 다른 방법을 찾을 수 있다. 따라서 이 경우 거절이 좋은 배려이다.",
              style: textTheme().bodyMedium,
              textAlign: TextAlign.center,
            ),
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
      child: Image.asset(controller.character.image),  // 실제 이미지 경로로 수정 필요
    );
  }
}
