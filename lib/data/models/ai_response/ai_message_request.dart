import 'package:json_annotation/json_annotation.dart';

part 'ai_message_request.g.dart';

@JsonSerializable()
class AIMessageRequest {
  final String persona;
  final String userName;
  final String userMessage;


  AIMessageRequest({
    required this.persona,
    required this.userName,
    required this.userMessage,
  });

  factory AIMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$AIMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AIMessageRequestToJson(this);
}
