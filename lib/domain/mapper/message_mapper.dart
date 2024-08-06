import 'package:palink_v2/data/models/message_response.dart';
import 'package:palink_v2/domain/models/chat/message.dart';

class MessageMapper {
  static Message toDomain(MessageResponse response) {
    return Message(
      messageId: response.messageId,
      sender: response.sender,
      messageText: response.messageText,
      timestamp: response.timestamp,
    );
  }
}
