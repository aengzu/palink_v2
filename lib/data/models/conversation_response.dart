import 'package:json_annotation/json_annotation.dart';

part 'conversation_response.g.dart';

@JsonSerializable()
class ConversationResponse {
  @JsonKey(name: 'conversation_id')
  final int conversationId;
  final String day;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'character_id')
  final int characterId;

  ConversationResponse({
    required this.conversationId,
    required this.day,
    required this.userId,
    required this.characterId,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) => _$ConversationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationResponseToJson(this);
}
