import 'package:json_annotation/json_annotation.dart';

part 'conversation_response.g.dart';

@JsonSerializable()
class ConversationResponse {
  final String day;
  final int userId;
  final int characterId;
  final int conversationId;

  ConversationResponse({
    required this.day,
    required this.userId,
    required this.characterId,
    required this.conversationId,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) => _$ConversationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationResponseToJson(this);
}

