import 'package:get/get.dart';

class TipButtonViewModel extends GetxController {
  var isExpanded = false.obs;
  var tipContent = ''.obs;
  var isLoading = false.obs; // 로딩 상태를 나타내는 변수 추가

  void updateTip(String newTip) {
    tipContent.value = newTip;
    isLoading.value = false;
    print('Tip updated: ${tipContent.value}'); // 디버깅 로그
  }

  void toggle() {
    isExpanded.value = !isExpanded.value;
    print('Tip expanded state: ${isExpanded.value}'); // 디버깅 로그
  }

  void startLoading() {
    isLoading.value = true;
    print('Tip loading started'); // 디버깅 로그
  }
}
