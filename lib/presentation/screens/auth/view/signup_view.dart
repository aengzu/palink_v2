import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/domain/controllers/auth/signup_controller.dart';
import 'package:palink_v2/presentation/screens/common/custom_btn.dart';
import 'package:palink_v2/utils/constants/app_fonts.dart';
import 'package:sizing/sizing.dart';
import 'package:flutter/services.dart'; // Import this package

class SignupView extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('회원가입', style: textTheme().titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (signUpController.errorMessage.value.isNotEmpty) {
            return Center(
                child: Text('Error: ${signUpController.errorMessage.value}'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(
                    controller: signUpController.memberIdController,
                    labelText: '사용자 ID',
                    hintText: '사용자 ID를 입력하세요.',
                  ),
                  SizedBox(height: 0.03.sh),
                  _buildTextField(
                    controller: signUpController.nameController,
                    labelText: '사용자 이름',
                    hintText: '사용자 이름을 입력하세요.',
                  ),
                  SizedBox(height: 0.03.sh),
                  _buildTextField(
                    controller: signUpController.passwordController,
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력하세요.',
                    isObscure: true,
                  ),
                  SizedBox(height: 0.03.sh),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: signUpController.ageController,
                          labelText: '나이',
                          hintText: '나이를 입력하세요.',
                          keyboardType: TextInputType.number,
                          // Set the keyboard type to number
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ], // Restrict input to digits
                        ),
                      ),
                      SizedBox(width: 0.03.sw), // Space between the two fields
                      Expanded(
                        child: _buildTextField(
                          controller:
                              signUpController.personalityTypeController,
                          labelText: 'MBTI',
                          hintText: 'MBTI를 입력하세요.',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.1.sh),
                  CustomButton(
                    label: signUpController.isLoading.value
                        ? '회원가입 중...'
                        : '회원가입하기',
                    onPressed: () {
                      _signUp();
                    },
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Future<void> _signUp() async {
    await signUpController.signUp(
      signUpController.memberIdController.text,
      signUpController.nameController.text,
      signUpController.passwordController.text,
      int.parse(signUpController.ageController.text),
      // Ensure age is parsed as int
      signUpController.personalityTypeController.text,
    );
    if (signUpController.errorMessage.value.isNotEmpty) {
      Get.snackbar('Error', signUpController.errorMessage.value,
          snackPosition: SnackPosition.TOP);
    } else {
      Get.snackbar('Success', '회원가입이 성공적으로 완료되었습니다.',
          snackPosition: SnackPosition.TOP);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    bool isObscure = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 라벨과 텍스트 필드를 왼쪽 정렬
      children: [
        Text(
          labelText,
          style: textTheme().titleSmall,
        ),
        SizedBox(height: 8), // 라벨과 텍스트 필드 사이의 간격 조정
        TextField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          // Set the keyboard type
          inputFormatters: inputFormatters,
          // Apply input formatters if any
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff134f91)),
            ),
            hintText: hintText,
            hintStyle: textTheme().bodyMedium,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
