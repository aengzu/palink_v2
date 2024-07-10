import 'package:get/get.dart';

import '../views/auth/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), _loadNextScreen);
  }

  void _loadNextScreen() {
    Get.offAll(() => LoginView());
  }
}
