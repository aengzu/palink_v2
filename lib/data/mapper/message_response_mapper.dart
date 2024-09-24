import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/domain/model/chat/message.dart';

extension MessageResponseMapper on MessageResponse {
  Message toDomain() {
    return Message(
      id: messageId.toString(),
      sender: sender,
      messageText: messageText,
      timestamp: timestamp,
    );
  }
}
