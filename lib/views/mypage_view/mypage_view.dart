import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/controller/user_controller.dart';
import '../../constants/app_fonts.dart';
import '../components/appbar_perferred_size.dart';

class MypageView extends StatelessWidget {
  MypageView({super.key});

  UserController userController = Get.put(UserController());

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
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        bottom: appBarBottomLine(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Obx(() => _buildUserInfo('아이디', userController.userId.value)),
            Obx(() => _buildUserInfo('이름', userController.name.value)),
            Obx(() => _buildUserInfo('나이', userController.age.value.toString())),
            Obx(() => _buildUserInfo('MBTI', userController.personalityType.value)),
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
