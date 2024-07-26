import 'package:get/get.dart';
import 'package:palink_v2/presentation/screens/auth/view/login_view.dart';

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
