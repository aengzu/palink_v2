import 'package:json_annotation/json_annotation.dart';

part 'likinglevel_response.g.dart';

@JsonSerializable()
class LikinglevelResponse {
  @JsonKey(name: 'message_id')
  final int messageId;
  final bool sender;
  @JsonKey(name: 'message_text')
  final String messageText;
  final String timestamp;
  @JsonKey(name: 'conversation_id')
  final int conversationId;

  LikinglevelResponse({
    required this.messageId,
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.conversationId,
  });

  factory LikinglevelResponse.fromJson(Map<String, dynamic> json) =>
      _$LikinglevelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LikinglevelResponseToJson(this);
}
