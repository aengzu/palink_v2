import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  final bool sender;
  final String messageText;
  final String timestamp;

  @JsonKey(name: 'ai_response', includeIfNull: false)
  final AIResponse? aiResponse;

  MessageRequest({
    required this.sender,
    required this.messageText,
    required this.timestamp,
    this.aiResponse, // aiResponse 필드를 nullable로 처리
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => _$MessageRequestFromJson(json);
  Map<String, dynamic> toJson() => {
    'sender': sender,
    'messageText': messageText,
    'timestamp': timestamp,
    'ai_response': aiResponse!.toJson(),
  };
  }
