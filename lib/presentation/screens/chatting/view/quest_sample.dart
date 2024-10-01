import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/chat_profile_section.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'package:sizing/sizing.dart';
import 'components/messages.dart';
import 'components/tip_button.dart';

class QuestSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white, // 기본 배경색 = 하얀색
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          toolbarHeight: 0.1.sh,
          title: ProfileSection(
            imagePath: '',
            characterName: '미연',
            questStatus: [false, true, false, false, false].obs,
            onProfileTapped: () =>
                showQuestPopup(context), // 프로필 클릭 시 퀘스트 팝업 표시,
            unachievedQuests: ['상대방이 처한 상황을 파악하기 위한 대화 시도', '이것은 미달성된 퀘스트이에요 가나다라마바사아자차가', '퀘스트3'].obs,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        extendBodyBehindAppBar: false,
        body: const Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text('         메시지')
              ],
            ),
      ],
    ),
    ),
    );
  }


  void showQuestPopup(BuildContext context) async {
      const questInfo = '상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기';
      // questInfo를 '\n'을 기준으로 분리하여 리스트로 변환
      List<String> questItems = questInfo.split('\n');

      await Get.dialog(
        Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '미연과 대화 진행 시 퀘스트',
                  style: textTheme().titleMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  '퀘스트는 프로필 상단 우측에 표시됩니다.\n퀘스트를 달성하면 퀘스트 아이콘 옆에 체크 표시가 나타납니다.\n 퀘스트를 확인하고 싶다면 프로필을 클릭하세요',
                  style: textTheme().bodySmall,
                ),
                const SizedBox(height: 10),
                // questItems 리스트를 순회하며 각각 Text 위젯을 추가하고 사이에 SizedBox로 간격 추가
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: questInfo.split('\n').map((quest) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0), // 각 항목 사이에 간격 추가
                      child: Text(
                        quest,
                        style: textTheme().bodyMedium,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                CustomButtonMD(
                  onPressed: () {
                    Get.back(); // 다이얼로그 닫기
                  },
                  label: '확인했습니다!',
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

