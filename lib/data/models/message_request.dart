import 'package:json_annotation/json_annotation.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  final bool sender;
  @JsonKey(name: 'message_text')
  final String messageText;
  final String timestamp;
  @JsonKey(name: 'conversation_id')
  final int conversationId;

  MessageRequest({
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.conversationId,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => _$MessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}
