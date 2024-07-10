import 'message.dart';

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

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['conversation_id'],
      day: json['day'],
      userId: json['user_id'],
      characterId: json['character_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'user_id': userId,
      'character_id': characterId,
    };
  }
}

class ConversationDto {
  String day;
  String userId;
  int characterId;

  ConversationDto({
    required this.day,
    required this.userId,
    required this.characterId,
  });

  factory ConversationDto.fromJson(Map<String, dynamic> json) {
    return ConversationDto(
      day: json['day'],
      userId: json['user_id'],
      characterId: json['character_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'user_id': userId,
      'character_id': characterId,
    };
  }
}
