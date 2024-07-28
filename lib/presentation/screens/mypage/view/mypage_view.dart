// presentation/screens/mypage/mypage_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';

import '../../common/appbar_perferred_size.dart';


class MypageView extends StatelessWidget {
  final MypageViewmodel mypageViewmodel = Get.put(getIt<MypageViewmodel>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('PALINK', style: textTheme().titleLarge),
        centerTitle: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('준비중입니다. \n다음 업데이트를 기대해주세요 ☺️'),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('닫기', style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              }
          ),
        ],
        bottom: appBarBottomLine(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Obx(() => _buildUserInfo('아이디', mypageViewmodel.userId.value)),
            Obx(() => _buildUserInfo('이름', mypageViewmodel.name.value)),
            Obx(() => _buildUserInfo('나이', mypageViewmodel.age.value.toString())),
            Obx(() => _buildUserInfo('MBTI', mypageViewmodel.personalityType.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme().titleMedium),
          Text(value, style: textTheme().bodyMedium),
        ],
      ),
    );
  }
}
