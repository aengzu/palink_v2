import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';


extension MessageResponseMapper on MessageResponse {
  Message toDomain() {
    return Message(
      sender: sender,
      messageText: messageText,
      timestamp: timestamp,
      affinityScore: 50,
      rejectionScore: 0,
    );
  }
}

