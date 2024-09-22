import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  final bool sender;
  final String messageText;
  final String timestamp;
  final AIResponse aiResponse;

  MessageRequest({
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.aiResponse,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => _$MessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}