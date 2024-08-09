import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/liking_bar.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:palink_v2/presentation/screens/common/custom_btn.dart';
import 'package:palink_v2/presentation/screens/feedback/controller/feedback_viewmodel.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';
import 'package:sizing/sizing.dart';

class FeedbackView extends StatelessWidget {
  final FeedbackViewmodel viewModel;

  FeedbackView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('대화 최종 피드백'),
        bottom: appBarBottomLine(),
      ),
      body: Column(
        children: [
          // 고정된 높이의 스크롤 가능한 영역
          SizedBox(
            height: 0.7.sh, // 화면 높이의 70%
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '평가',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  _buildProfileImage(),
                  SizedBox(height: 0.04.sh),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    width: 0.9.sw,
                    color: AppColors.lightBlue,
                    child: Text(
                      viewModel.analysisDto.evaluation,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 0.03.sh),
                  const Text(
                    '최종 호감도',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  LikingBar(viewModel.analysisDto.finalRejectionScore),
                  Text('최종 호감도 ${viewModel.analysisDto.finalRejectionScore}점'),
                  SizedBox(height: 0.05.sh),
                  const Text(
                    '사용한 거절 방법',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(viewModel.analysisDto.usedRejection),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // 버튼을 하단에 위치시키기
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CustomButton(
                onPressed: () {
                  // 다음으로 버튼 누를 때의 동작 추가
                  Get.off(() => MainScreens());
                },
                label: '다음으로',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 120,
      height: 120,
      child: Image.asset(viewModel.character.image), // 실제 이미지 경로로 수정 필요
    );
  }
}
