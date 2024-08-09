import 'package:get/get.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/usecase/generate_tip_usecase.dart';

class TipViewModel extends GetxController {
  var isExpanded = false.obs;
  var tipContent = ''.obs;
  var isLoading = false.obs;
  final GenerateTipUsecase generateTipUsecase = getIt<GenerateTipUsecase>();

  void updateTip(String newTip) {
    tipContent.value = newTip;
    isLoading.value = false;
    print('Tip updated: $newTip'); // 로그 추가
  }

  void toggle() {
    isExpanded.value = !isExpanded.value;
    print('Tip expanded state: ${isExpanded.value}'); // 로그 추가
  }

  void startLoading() {
    isLoading.value = true;
    print('Tip loading started'); // 로그 추가
  }

  Future<void> generateTip(Message message) async {
    print('generateTip called with message: ${message.messageText}'); // 로그 추가
    startLoading();
    final tip = await generateTipUsecase.execute(message.messageText);
    if (tip != null) {
      print('Tip generated: ${tip.answer}'); // 로그 추가
      updateTip(tip.answer);
    } else {
      print('No tip available'); // 로그 추가
      updateTip('No tip available.');
    }
  }
}
