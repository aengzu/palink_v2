import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:palink_v2/core/constants/app_images.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';

class ProfileSection extends StatelessWidget {
  final MypageViewModel mypageViewmodel;

  ProfileSection({required this.mypageViewmodel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              ImageAssets.defaultProfile,
              width: 90,
              height: 90,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('내 이름은', style: TextStyle(fontSize: 15, color: Colors.grey[900])),
                const SizedBox(height: 3),
                Obx(() => Text(
                  mypageViewmodel.name.value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}