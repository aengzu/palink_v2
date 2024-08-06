import 'package:palink_v2/data/models/conversation_response.dart';

class Conversation {
  int conversationId;
  String day;
  String userId;
  int characterId;

  Conversation({
    required this.conversationId,
    required this.day,
    required this.userId,
    required this.characterId,
  });

  // fromResponse 메서드 추가
  factory Conversation.fromResponse(ConversationResponse response) {
    return Conversation(
      conversationId: response.conversationId,
      day: response.day,
      userId: response.userId,
      characterId: response.characterId,
    );
  }
}
