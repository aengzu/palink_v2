import 'dart:convert';
import 'package:get/get.dart';
import 'package:palink_v2/models/chat/message.dart';
import 'package:palink_v2/services/openai_service.dart';
import '../models/character.dart';
import '../views/feedback/feedback_view.dart';


class ConversationEndController extends GetxController {
  final Character character;
  final List<Message> messages;
  final int conversationId;
  var analyzeResult = {}.obs;
  var rejectionScore = 0.obs; // RxInt로 선언
  final RxInt likingLevel; // RxInt로 선언

  ConversationEndController(this.character, this.messages, this.conversationId, int initialLikingLevel)
      : likingLevel = initialLikingLevel.obs; // 초기 값 설정

  @override
  void onInit() {
    super.onInit();
    invokeAnalyze();
  }

  Future<void> invokeAnalyze() async {
    OpenAIService openAIService = OpenAIService(character, conversationId);
    print(messages.toString());

    // messages 리스트를 JSON 문자열로 변환
    String messagesJson = jsonEncode(messages.map((message) => message.toJson()).toList());
    print(messagesJson);

    Map? result = await openAIService.invokeAnalyze(messagesJson);

    if (result != null) {
      analyzeResult.value = result;
      if (result['evaluation'] != null && result['evaluation'] is Map) {
        // 'evaluation'이 Map일 때 처리
        final evaluation = result['evaluation'] as Map<String, dynamic>;
        rejectionScore.value = evaluation['final_rejection_score'] ?? 0;
      }
      Get.to(() => FeedbackView(controller: this)); // 결과를 전달하며 피드백 뷰로 이동합니다.
    } else {
      print('Failed to analyze the conversation');
    }
  }
}
