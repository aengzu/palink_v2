// lib/utils/message_utils.dart

import 'package:palink_v2/domain/models/chat/ai_response.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:uuid/uuid.dart';

class MessageUtils {
  // 서버에 메시지 저장할 때 MessageDto 로 보내야함
  // 서버에서 받은 메시지를 Message로 변환해서 사용해야함

  // text 와 conversationId 를 주면 알아서 MessageDto 만드는 것.
  static MessageDto createUserMessageDto(String text, int conversationId) {
    return MessageDto(
      sender: true,
      messageText: text,
      timestamp: DateTime.now().toIso8601String(),
      conversationId: conversationId,
    );
  }

  // text 와 conversatioId 를 주면 Message 를 만듬
  // 이때 생성되는 메시지객체는 더미 메시지(messageId를 임의로 부여한 것)
  static Message createUserMessage(String text, int conversationId) {
    return Message(
      // 더미 메시지 아이디 생성
      messageId: const Uuid().v4().hashCode,
      sender: true,
      messageText: text,
      timestamp: DateTime.now().toIso8601String(),
      conversationId: conversationId,
    );
  }

  // AIResponse 객체를 MessageDto 로 변환
  static MessageDto convertAIMessageToMessageDto(
      AIResponse aiResponse, int conversationId) {
    return MessageDto(
      sender: false,
      messageText: aiResponse.text,
      timestamp: DateTime.now().toIso8601String(),
      conversationId: conversationId,
    );
  }
}
