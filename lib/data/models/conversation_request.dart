import 'package:json_annotation/json_annotation.dart';

part 'conversation_request.g.dart';

@JsonSerializable()
class ConversationRequest {
  final String day;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'character_id')
  final int characterId;

  ConversationRequest({
    required this.day,
    required this.userId,
    required this.characterId,
  });

  factory ConversationRequest.fromJson(Map<String, dynamic> json) => _$ConversationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationRequestToJson(this);
}
