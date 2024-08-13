import 'package:json_annotation/json_annotation.dart';

part 'emotion_response.g.dart';

@JsonSerializable()
class EmotionResponse {
  final String emotionType;
  final int vibrationPattern;
  final String backgroundColor;
  final int messageId;
  final int emotionId;

  EmotionResponse({
    required this.emotionType,
    required this.vibrationPattern,
    required this.backgroundColor,
    required this.messageId,
    required this.emotionId,
  });

  factory EmotionResponse.fromJson(Map<String, dynamic> json) => _$EmotionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmotionResponseToJson(this);
}
