
import 'package:json_annotation/json_annotation.dart';
part 'emotion.g.dart';

@JsonSerializable()
class Emotion {
  final String emotionType;
  final String vibrationPattern;
  final String backgroundColor;

  Emotion(
      {required this.emotionType,
      required this.vibrationPattern,
      required this.backgroundColor});

  factory Emotion.fromJson(Map<String, dynamic> json) => _$EmotionFromJson(json);

  Map<String, dynamic> toJson() => _$EmotionToJson(this);
}
