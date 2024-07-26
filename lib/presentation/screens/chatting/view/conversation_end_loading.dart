import 'package:flutter/material.dart';
import 'package:palink_v2/domain/controllers/conversation_end_controller.dart';
import 'package:palink_v2/utils/constants/app_fonts.dart';
import 'package:sizing/sizing.dart';


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
            padding:
                EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: '\n',
                children: <TextSpan>[
                  TextSpan(
                      text: '  모든 사람을 만족시킬 수는 없다.\n',
                      style: textTheme().titleMedium),
                  TextSpan(
                      text:
                          '\n모든 사람을 만족시키려 하면 자신을 잃게 됩니다. 스스로를 우선시하는 것이 중요합니다. 이는 우리의 정신적, 감정적 건강을\n 지키는 데 필요합니다.',
                      style: textTheme().bodyMedium),
                ],
              ),
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
      child: Image.asset(controller.character.image), // 실제 이미지 경로로 수정 필요
    );
  }
}
