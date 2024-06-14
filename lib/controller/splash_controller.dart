import 'package:get/get.dart';
import 'package:palink_v2/views/auth_view/login_view.dart';
import 'package:palink_v2/views/character_select_view/character_select_view.dart';


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

