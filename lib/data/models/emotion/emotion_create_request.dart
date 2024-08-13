import 'package:json_annotation/json_annotation.dart';

part 'emotion_create_request.g.dart';

@JsonSerializable()
class EmotionCreateRequest {
  final String emotionType;
  final int vibrationPattern;
  final String backgroundColor;
  final int messageId;

  EmotionCreateRequest({
    required this.emotionType,
    required this.vibrationPattern,
    required this.backgroundColor,
    required this.messageId,
  });

  factory EmotionCreateRequest.fromJson(Map<String, dynamic> json) => _$EmotionCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EmotionCreateRequestToJson(this);
}
