import 'package:json_annotation/json_annotation.dart';

part 'chat_request.g.dart';

@JsonSerializable()
class ChatRequest {
  final String persona;
  final String userName;
  final String userMessage;


  ChatRequest({
    required this.persona,
    required this.userName,
    required this.userMessage,
  });

  factory ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRequestToJson(this);
}
