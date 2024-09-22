import 'package:json_annotation/json_annotation.dart';

part 'ai_response_response.g.dart';

@JsonSerializable()
class AIResponseResponse {
  final String feeling;
  final String text;
  @JsonKey(name: 'rejection_score')
  final List<int> rejectionScore;
  final String userMessage;
  @JsonKey(name: 'final_affinity_score')
  final int finalAffinityScore;
  @JsonKey(name: 'affinity_score')
  final int affinityScore;
  final int aiMessage;
  @JsonKey(name: 'rejection_content')
  final List<String> rejectionContent;
  @JsonKey(name: 'final_rejection_score')
  final int finalRejectionScore;
  @JsonKey(name: 'conversation_id')
  final int conversationId;

  AIResponseResponse({
    required this.feeling,
    required this.text,
    required this.rejectionScore,
    required this.userMessage,
    required this.finalAffinityScore,
    required this.affinityScore,
    required this.aiMessage,
    required this.rejectionContent,
    required this.finalRejectionScore,
    required this.conversationId,
  });

  factory AIResponseResponse.fromJson(Map<String, dynamic> json) => _$AIResponseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AIResponseResponseToJson(this);
}
