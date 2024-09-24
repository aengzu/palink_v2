import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/domain/model/chat/conversation.dart';

extension ConversationMapper on ConversationResponse {
  Conversation toDomain() {
    return Conversation(
      conversationId: conversationId,
      day: DateTime.parse(day),
      userId: userId,
      characterId: characterId,
    );
  }
}
