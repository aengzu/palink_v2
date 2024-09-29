import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/messages.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/chat_history_viewmodel.dart';
import 'package:sizing/sizing.dart';

import 'feedback_history_view.dart';

class ChatHistoryView extends StatelessWidget {
  final int chatroomId;
  final ChatHistoryViewmodel viewModel;
  final Character character;

  ChatHistoryView({required this.chatroomId, required this.character})
      : viewModel = Get.put(ChatHistoryViewmodel(chatroomId: chatroomId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('대화 기록'),
        bottom: appBarBottomLine(),
      ),
      body: Stack(
        children: [
          // 메시지 섹션이 스크롤 가능하도록 설정
          Positioned.fill(
            child: Obx(() {
              // 대화 데이터가 로드되지 않은 경우
              if (viewModel.conversationNotFound.value) {
                return const Center(
                  child: Text(
                    '대화가 저장되지 않았습니다.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              // 대화가 있는 경우 메시지 리스트를 표시
              return SingleChildScrollView(
                child: SizedBox(
                  height: 0.8.sh,
                  child: Messages(
                    messages: viewModel.messages ?? [],
                    userId: chatroomId,
                    characterImg: character.image ?? '',
                    onReactionAdded: (message, reaction) {},
                  ),
                ),
              );
            }),
          ),
          // 버튼을 하단에 고정
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 피드백 보기 버튼 추가
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0), // 버튼 크기 조절
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // 네모난 모서리
                        ),
                      ),
                      onPressed: () {
                        Get.off(() => const MainScreens());
                      },
                      child: const Text('홈 화면으로'),
                    ),
                    const SizedBox(width: 20), // 버튼 사이의 간격 추가
                    // 홈 화면으로 버튼
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0), // 버튼 크기 조절
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // 네모난 모서리
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => FeedbackHistoryView(
                          chatroomId: chatroomId,
                          character: character,
                        ));
                      },
                      child: const Text('피드백 보기'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
