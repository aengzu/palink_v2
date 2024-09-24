import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/domain/model/chat/message.dart';

class MessageResponseMapper {
  // MessageResponse를 Message로 변환하는 메서드
  Message toMessage(MessageResponse response) {
    return Message(
      id: response.messageId.toString(),
      sender: response.sender,
      messageText: response.messageText,
      timestamp: response.timestamp,
    );
  }
}
