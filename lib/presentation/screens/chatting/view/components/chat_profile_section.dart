import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/custom_quest_button.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/profile_image.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/quest_box.dart';
import 'package:sizing/sizing.dart';

class ProfileSection extends StatelessWidget {
  final String imagePath;
  final String characterName;
  final RxList<bool> questStatus;
  final Function onProfileTapped; // 다이얼로그를 여는 함수
  final RxList<String> unachievedQuests;

  ProfileSection({
    required this.imagePath,
    required this.characterName,
    required this.questStatus,
    required this.onProfileTapped, // 다이얼로그 트리거 전달
    required this.unachievedQuests,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 0.45.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => QuestBox(questText: getCurrentQuest())), // 상태 변화를 감지하여 업데이트
                ],
              ),
            ),
          ),
          Obx(() => InkWell(
            onTap: () => onProfileTapped(),
            child: Column(
              children: [
                // Text('퀘스트 달성 현황', style: textTheme().bodySmall?.copyWith(color: Colors.grey[600], fontWeight: FontWeight.normal, fontSize: 11)),
                // const SizedBox(height: 8),
                // 이 아래의 리스트를 완전 작게 만들고싶음 9todo
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        questStatus[index] ? Icons.check_circle : Icons.circle_outlined,
                        color: questStatus[index] ? Colors.blue : Colors.grey,
                        size: 12,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                CustomQuestButton(
                  label: '퀘스트 보기',
                  onPressed: () {
                    onProfileTapped();
                  },
                ),
              ],
            ),
          )),
        ],
    );
  }

  // 미달성 퀘스트 중 첫 번째 퀘스트 가져오는 함수 단 퀘스트가
  String getCurrentQuest() {
    return unachievedQuests.isNotEmpty
        ? unachievedQuests.first
        : '모든 퀘스트를 달성했습니다!';
  }
}
