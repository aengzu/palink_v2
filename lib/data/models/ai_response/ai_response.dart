import 'package:json_annotation/json_annotation.dart';

part 'ai_response.g.dart';

@JsonSerializable()
class AIResponse {
  final String text;
  @JsonKey(name: 'feeling')
  final String feeling;
  @JsonKey(name: 'achieved_quest')
  final String achievedQuest;
  @JsonKey(name: 'final_rejection_score')
  final int finalRejectionScore;
  @JsonKey(name: 'rejection_score')
  final int rejectionScore;
  @JsonKey(name: 'rejection_contents')
  final String rejectionContents;
  @JsonKey(name: 'affinity_score')
  final int affinityScore;
  @JsonKey(name: 'is_end')
  final int isEnd;

  AIResponse({
    required this.text,
    required this.feeling,
    required this.achievedQuest,
    required this.finalRejectionScore,
    required this.rejectionScore,
    required this.rejectionContents,
    required this.affinityScore,
    required this.isEnd,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) =>
      _$AIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AIResponseToJson(this);
}
