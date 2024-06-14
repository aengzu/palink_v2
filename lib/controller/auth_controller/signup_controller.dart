import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:palink_v2/views/auth_view/login_view.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';


class SignUpController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  TextEditingController memberIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController personalityTypeController = TextEditingController();

  AuthService authService = AuthService();

  Future<void> signUp(String userId, String name, String password, int age, String personalityType) async {
    UserSignDto userSignDto = UserSignDto(
      userId: userId,
      name: name,
      password: password,
      age: age,
      personalityType: personalityType,
    );

    isLoading.value = true;
    errorMessage.value = '';

    try {
      bool success = await authService.signUp(userSignDto);

      if (success) {
        // Signup successful
        Get.to(LoginView());
      } else {
        errorMessage.value = 'Failed to sign up';
        Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      errorMessage.value = 'Failed to sign up: $e';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.TOP);
      print('Failed to sign up: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
