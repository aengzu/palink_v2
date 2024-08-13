import 'package:json_annotation/json_annotation.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  final bool sender;
  final String messageText;
  final String timestamp;

  MessageRequest({
    required this.sender,
    required this.messageText,
    required this.timestamp,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => _$MessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}
