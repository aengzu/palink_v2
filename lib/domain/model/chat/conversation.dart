import 'package:palink_v2/data/models/chat/conversation_response.dart';

class Conversation {
  DateTime day;
  int userId;
  int characterId;
  int conversationId;

  Conversation({
    required this.day,
    required this.userId,
    required this.characterId,
    required this.conversationId,
  });

  // fromResponse 메서드 추가
  factory Conversation.fromResponse(ConversationResponse response) {
    return Conversation(
      conversationId: response.conversationId,
      day: DateTime.parse(response.day),
      userId: response.userId,
      characterId: response.characterId,
    );
  }
}
