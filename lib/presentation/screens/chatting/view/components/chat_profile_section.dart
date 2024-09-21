import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/profile_image.dart';
import 'package:sizing/sizing.dart';

class ProfileSection extends StatelessWidget {
  final String imagePath;
  final String characterName;
  final RxList<bool> questStatus;
  final Function onProfileTapped; // 다이얼로그를 여는 함수

  ProfileSection({
    required this.imagePath,
    required this.characterName,
    required this.questStatus,
    required this.onProfileTapped, // 다이얼로그 트리거 전달
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          ProfileImage(
            path: imagePath,
            imageSize: 0.07.sh,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              width: 0.45.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    characterName,
                    style: textTheme().bodyLarge?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => InkWell(
            onTap: () => onProfileTapped(),
            child: Row(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    questStatus[index] ? Icons.check_circle : Icons.circle,
                    color: questStatus[index] ? Colors.blue : Colors.grey,
                    size: 16,
                  ),
                );
              }),
            ),
          )),
        ],
    );
  }
}
