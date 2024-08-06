import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/conversation_end_controller.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/liking_bar.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:palink_v2/presentation/screens/common/custom_btn.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';
import 'package:sizing/sizing.dart';


class FeedbackView extends StatelessWidget {
  final ConversationEndController controller;

  FeedbackView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('대화 최종 피드백'),
        bottom: appBarBottomLine(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final result = controller.analyzeResult.value;
          if (result.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('평가',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 0.04.sh),
                  if (result['evaluation'] is Map)
                    ...result['evaluation'].entries.map<Widget>((entry) {
                      final value = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('메시지 ID: ${entry.key}'),
                          Text('사용한 거절: ${value['used_rejection']}'),
                          Text('최종 거절 점수: ${value['final_rejection_score']}'),
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList()
                  else
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _buildProfileImage(),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        width: 0.5.sw,
                        color: AppColors.lightBlue,
                        child: Text(result['evaluation'].toString()),
                      )
                    ]),
                  SizedBox(height: 0.05.sh),
                  Text('최종 호감도',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  LikingBar(controller.likingLevel.value as int),
                  Text('최종 호감도 ${controller.likingLevel.value}점'),
                  // RxInt의 값 접근
                  SizedBox(height: 0.05.sh),
                  Text('사용한 거절 방법',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  if (result['used_rejection'] is String)
                    Text(result['used_rejection'].toString())
                  else if (result['used_rejection'] is Map)
                    ...result['used_rejection'].entries.map<Widget>((entry) {
                      return Text('${entry.key}: ${entry.value}');
                    }).toList(),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        // 다음으로 버튼 누를 때의 동작 추가
                        Get.off(() => MainScreens());
                      },
                      label: '다음으로',
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: EdgeInsets.all(10),
      width: 80,
      height: 80,
      child: Image.asset(controller.character.image),
      margin: EdgeInsets.only(right: 0.06.sw),
    );
  }
}
