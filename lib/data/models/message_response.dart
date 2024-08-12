import 'package:json_annotation/json_annotation.dart';
part 'message_response.g.dart';

@JsonSerializable()
class MessageResponse {
  @JsonKey(name: 'message_id')
  final int messageId;
  final bool sender;
  @JsonKey(name: 'message_text')
  final String messageText;
  final String timestamp;
  @JsonKey(name: 'conversation_id')
  final int conversationId;

  MessageResponse({
    required this.messageId,
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.conversationId,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) => _$MessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);


}
