import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_loading_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_viewmodel.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'package:sizing/sizing.dart';

import 'chat_screen.dart';


class ChatLoadingScreen extends StatelessWidget {
  final ChatLoadingViewModel viewModel;

  // 생성자에서 Character 인자를 받도록 수정
  const ChatLoadingScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.1.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.7.sh,
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      _buildProfileImage(),
                      Center(
                        child: Text(
                          "${viewModel.character.name}의 배경" ,
                          style: textTheme().titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 0.07.sw, vertical: 0.02.sh),
                        child: _buildStyledDescription(viewModel.character.description!),
                      ),
                    ],
                  ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              // 로딩이 끝나면 '채팅 시작하기' 버튼을 표시
              if (!viewModel.isLoading.value) {
                return Column(
                  children: [
                    Text('캐릭터의 성격을 파악하셨나요?', style: textTheme().bodyMedium?.copyWith(color: Colors.black38, fontSize: 14.0)),
                    const SizedBox(height: 12),
                    CustomButtonMD(label: '채팅 시작하기', onPressed: () {
                      _startChat(); // 버튼 눌렀을 때 채팅 화면으로 이동
                    }),
                  ],
                );
              } else {
                return const SpinKitThreeBounce(color: AppColors.deepBlue, size: 30); // 로딩 중일 때는 빈 위젯 반환
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 120,
      height: 120,
      child: Image.asset(viewModel.character.image),
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
            style: textTheme().titleSmall?.copyWith(color: Colors.black54, fontSize: 16.0, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 18.0), // 타이틀과 나머지 텍스트 간 간격
        for (var i = 1; i < lines.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 6.0), // 아이콘과 텍스트 사이의 간격
                child: Icon(Icons.check_circle, color: Colors.blue, size: 16),
              ),
              Expanded(
                child: Text(
                  lines[i],
                  style: textTheme().bodyMedium?.copyWith(height: 1.4),
                ),
              ),
            ],
          ),
          // 마지막 아이템을 제외하고 Divider를 추가
          if (i < lines.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Divider(
                color: Colors.grey, // 선 색깔
                thickness: 0.5, // 선 두께
                height: 16.0, // 위아래 간격
              ),
            ),
        ],
      ],
    );
  }


  // 채팅 화면으로 이동하는 메소드
  void _startChat() {
    final conversationId = viewModel.conversation.value?.conversationId;
    final tip = viewModel.initialTip.value; // 새로운 팁 변수 사용
    final initialIsEnd = viewModel.isEnd.value; // 새로운 isEnd 변수 사용

    Get.off(() => ChatScreen(
      viewModel: Get.put(ChatViewModel(chatRoomId: conversationId!, character: viewModel.character)),
      initialTip: tip,
      initialIsEnd: initialIsEnd,
    ));
  }
}