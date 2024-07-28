import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:palink_v2/domain/models/auth/signup_model.dart';
import 'package:palink_v2/domain/models/user.dart';
import 'package:palink_v2/domain/usecase/sign_up_usecase.dart';
import 'package:palink_v2/presentation/screens/main_screens.dart';

class SignupViewModel extends GetxController {
  final SignUpUseCase signUpUseCase;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var user = Rxn<User>();

  SignupViewModel({required this.signUpUseCase});

  Future<void> signUp(String userId, String password, String name, int age,
      String personalityType) async {
    if (userId.isEmpty || password.isEmpty) {
      _showError('아이디와 비밀번호를 입력해주세요!');
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await signUpUseCase.execute(SignupModel(
          userId: userId,
          password: password,
          name: name,
          age: age,
          personalityType: personalityType));
      if (result != null) {
        // 가입 성공
        Get.off(() => const MainScreens());
      } else {
        _showError('회원가입에 실패했습니다.n');
      }
    } catch (e) {
      _showError('Failed to signUp: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    errorMessage.value = message;
    Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
  }
}
