// TipButtonViewModel 추가

import 'package:get/get.dart';

class TipButtonViewModel extends GetxController {
  var isExpanded = false.obs;
  var tipContent = ''.obs;

  void toggle() {
    isExpanded.value = !isExpanded.value;
  }

  void updateTip(String newTip) {
    tipContent.value = newTip;
    print('Tip updated: ${tipContent.value}');
  }
}