// lib/utils/message_utils.dart

import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:uuid/uuid.dart';

class MessageUtils {
  // 서버에 메시지 저장할 때 MessageDto 로 보내야함
  // 서버에서 받은 메시지를 Message로 변환해서 사용해야함

  // text 와 conversationId 를 주면 알아서 MessageDto 만드는 것.
  static MessageRequest createUserMessageDto(String text, int conversationId) {
    return MessageRequest(
      sender: true,
      messageText: text,
      timestamp: DateTime.now().toIso8601String(),
      conversationId: conversationId,
    );
  }


  // AIResponse 객체를 MessageDto 로 변환
  static MessageRequest convertAIMessageToMessageDto(
      AIResponse aiResponse, int conversationId) {
    return MessageRequest(
      sender: false,
      messageText: aiResponse.text,
      timestamp: DateTime.now().toIso8601String(),
      conversationId: conversationId,
    );
  }
}
