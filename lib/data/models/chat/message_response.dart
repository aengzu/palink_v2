import 'package:json_annotation/json_annotation.dart';
part 'message_response.g.dart';

@JsonSerializable()
class MessageResponse {
  final bool sender;
  final String messageText;
  final String timestamp;
  final int messageId;
  final int conversationId;

  MessageResponse({
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.messageId,
    required this.conversationId,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) => _$MessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);

}
