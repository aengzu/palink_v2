import 'package:json_annotation/json_annotation.dart';

part 'ai_response.g.dart';

@JsonSerializable()
class AIResponse {
  final String text;
  @JsonKey(name: 'is_end')
  final int isEnd;
  @JsonKey(name: 'affinity_score')
  final int affinityScore;
  @JsonKey(name: 'expected_emotion')
  final String expectedEmotion;
  @JsonKey(name: 'rejection_score')
  final int rejectionScore;

  AIResponse({
    required this.text,
    required this.isEnd,
    required this.affinityScore,
    required this.expectedEmotion,
    required this.rejectionScore,
  });

   factory AIResponse.fromJson(Map<String, dynamic> json) => _$AIResponseFromJson(json);
}


