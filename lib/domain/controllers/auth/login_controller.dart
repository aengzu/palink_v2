import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:palink_v2/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';
import '../../models/user.dart';

import '../user_controller.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  UserController userController = Get.put(UserController());
  TextEditingController memberIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();

  Future<void> login(String userId, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to login with user ID: $userId'); // 디버깅 메시지 추가
      User? user = await authService.login(userId, password);

      if (user != null) {
        // 로그인 성공
        userController.setUser(user); // 유저 정보를 UserController에 설정
        await saveUserData(user); // 사용자 정보를 SharedPreferences에 저장
        Get.off(() => MainScreens());
      } else {
        errorMessage.value = 'Failed to login';
        Get.snackbar('Error', errorMessage.value,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      errorMessage.value = 'Failed to login: $e';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.TOP);
      print('Failed to login: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveUserData(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', user.userId);
      await prefs.setString('name', user.name);
      await prefs.setInt('age', user.age);
      await prefs.setString('personality_type', user.personalityType);
      print('User data saved successfully'); // 디버깅 메시지 추가
    } catch (e) {
      print('Failed to save user data: $e');
    }
  }
}
