import 'package:json_annotation/json_annotation.dart';

part 'ai_response_response.g.dart';

@JsonSerializable()
class AIResponseResponse {
  final String feeling;
  final String text;
  final List<int> rejectionScore;
  final String userMessage;
  final int finalAffinityScore;
  final int affinityScore;
  final int aiMessage;
  final List<String> rejectionContent;
  final int finalRejectionScore;
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
