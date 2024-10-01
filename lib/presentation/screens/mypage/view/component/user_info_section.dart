import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';

class UserInfoCard extends StatelessWidget {
  final MypageViewModel mypageViewmodel;

  UserInfoCard({required this.mypageViewmodel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => _buildUserInfo('내 아이디', mypageViewmodel.accountId.value)),
            Obx(() => _buildUserInfo('내 나이', mypageViewmodel.age.value.toString())),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 23.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16.0)),
          Text(value, style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}