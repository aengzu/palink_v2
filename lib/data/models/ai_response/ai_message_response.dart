import 'package:json_annotation/json_annotation.dart';

part 'ai_message_response.g.dart';

@JsonSerializable()
class AIMessageResponse {
  final String message;
  final bool isEnd;


  AIMessageResponse({
    required this.message,
    required this.isEnd,
  });

  factory AIMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$AIMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AIMessageResponseToJson(this);
}
