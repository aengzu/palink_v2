import 'dart:convert';
import 'package:get/get.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/presentation/screens/feedback/view/feedback_view.dart';

class ConversationEndController extends GetxController {
  final Character character;
  final List<Message> messages;
  final int conversationId;
  var analyzeResult = {}.obs;
  var rejectionScore = 0.obs;
  final RxInt likingLevel;

  //final AnalyzeConversationUsecase analyzeConversationUsecase = getIt<AnalyzeConversationUsecase>();

  ConversationEndController(this.character, this.messages, this.conversationId, int initialLikingLevel)
      : likingLevel = initialLikingLevel.obs;

  @override
  void onInit() {
    super.onInit();
    invokeAnalyze();
  }

  Future<void> invokeAnalyze() async {
    // try {
     // final messagesJson = jsonEncode(messages.map((message) => message.toJson()).toList());
    //  Map? result = await analyzeConversationUsecase.execute(messagesJson);
    //
    //   if (result != null) {
    //     analyzeResult.value = result;
    //     if (result['evaluation'] != null && result['evaluation'] is Map) {
    //       final evaluation = result['evaluation'] as Map<String, dynamic>;
    //       rejectionScore.value = evaluation['final_rejection_score'] ?? 0;
    //     }
    //     Get.to(() => FeedbackView(controller: this)); // 결과를 전달하며 피드백 뷰로 이동합니다.
    //   } else {
    //     print('Failed to analyze the conversation');
    //   }
    // } catch (e) {
    //   print('Failed to analyze the conversation: $e');
    // }
  }
}
