// lib/utils/message_utils.dart

import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';


class MessageUtils {
  // AIResponse 객체를 MessageDto 로 변환
  static MessageRequest convertAIMessageToMessageRequest(AIResponse aiResponse) {
    return MessageRequest(
      sender: false,
      messageText: aiResponse.text,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
