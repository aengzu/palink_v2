
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';

extension AIResponseMapper on AIResponse {
  MessageRequest toMessageRequest() {
    return MessageRequest(
      sender: false,
      messageText: text,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
