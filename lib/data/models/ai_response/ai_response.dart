import 'package:json_annotation/json_annotation.dart';

part 'ai_response.g.dart';

@JsonSerializable()
class AIResponse {
  final String text;
  final String feeling;
  @JsonKey(name: 'affinity_score')
  final int affinityScore;
  @JsonKey(name: 'rejection_score')
  final List<int> rejectionScore;
  @JsonKey(name: 'rejection_content')
  final List<String> rejectionContent;
  @JsonKey(name: 'final_rejection_score')
  final int finalRejectionScore;
  @JsonKey(name: 'final_affinity_score')
  final int finalAffinityScore;

  AIResponse({
    required this.text,
    required this.feeling,
    required this.affinityScore,
    required this.rejectionScore,
    required this.rejectionContent,
    required this.finalRejectionScore,
    required this.finalAffinityScore,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) => _$AIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AIResponseToJson(this);
}