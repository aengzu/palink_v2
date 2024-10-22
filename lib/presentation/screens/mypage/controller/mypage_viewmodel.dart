import 'package:get/get.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/logout_usecase.dart';

class MypageViewModel extends GetxController {
  final GetUserInfoUseCase getUserInfoUseCase;
  final LogoutUsecase logoutUseCase;

  var accountId = ''.obs;
  var name = ''.obs;
  var age = 0.obs;
  var personalityType = ''.obs;

  MypageViewModel({required this.getUserInfoUseCase, required this.logoutUseCase});

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    try {
      final user = await getUserInfoUseCase.execute();
      if (user != null) {
        accountId.value = user.accountId.toString();
        name.value = user.name;
        age.value = user.age;
      } else {
        Get.snackbar('Error', 'Failed to load user data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while loading user data');
    }
  }

  void logout() {
    // 로그아웃 로직
    logoutUseCase.execute();
    // 로그아웃 후 초기 화면으로 이동
    Get.offAllNamed('/');
  }
}
