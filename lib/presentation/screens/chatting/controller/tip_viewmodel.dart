import 'package:get/get.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/usecase/generate_tip_usecase.dart';

class TipViewModel extends GetxController {
  var isExpanded = false.obs;
  var tipContent = ''.obs;
  var isLoading = false.obs;
  final GenerateTipUsecase generateTipUsecase = getIt<GenerateTipUsecase>();

  void updateTip(String newTip) {
    tipContent.value = newTip;
    isLoading.value = false;
  }

  void toggle() {
    isExpanded.value = !isExpanded.value;
  }

  void startLoading() {
    isLoading.value = true;
  }

  Future<void> generateTip(Message message) async {
    startLoading();
    final tip = await generateTipUsecase.execute(message.messageText);
    if (tip != null) {
      updateTip(tip.answer);
    } else {
      updateTip('팁 생성중입니다.');
    }
  }
}
