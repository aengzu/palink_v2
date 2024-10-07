import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/feedback_history_viewmodel.dart';
import 'package:sizing/sizing.dart';

class FeedbackHistoryView extends StatelessWidget {
  final int chatroomId;
  final FeedbackHistoryViewModel viewModel;
  final Character character;

  FeedbackHistoryView({required this.chatroomId, required this.character})
      : viewModel = Get.put(FeedbackHistoryViewModel(chatroomId: chatroomId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('대화 최종 피드백'),
        bottom: appBarBottomLine(),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: Obx(() {
              // 피드백이 없는 경우
              if (viewModel.feedbackNotFound.value) {
                return const Center(
                  child: Text(
                    '피드백이 저장되지 않았습니다.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              // 피드백 데이터가 로드되지 않은 경우
              if (viewModel.feedback == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '평가',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    _buildProfileImage(),
                    SizedBox(height: 0.045.sh),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      width: 0.9.sw,
                      color: AppColors.lightBlue,
                      child: Text(
                        viewModel.feedback!.feedbackText ?? '피드백 내용이 없습니다.',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 0.05.sh),
                  ],
                ),
              );
            }),
          ),
          // Fixed button at the bottom
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.3.sw),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Get.off(() => const MainScreens());
                },
                child: const Text('홈 화면으로'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 프로필 이미지 표시, character가 null일 경우 대체 이미지 보여주기
  Widget _buildProfileImage() {
    if (character == null || character.image == null) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.person,
          size: 80,
          color: Colors.white,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      width: 120,
      height: 120,
      child: Image.asset(character.image ?? ''),
    );
  }
}
