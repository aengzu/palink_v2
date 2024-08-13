import 'package:json_annotation/json_annotation.dart';

part 'feedback_response.g.dart';

@JsonSerializable()
class FeedbackResponse {
  final int conversationId;
  final String feedbackText;
  final int finalLikingLevel;
  final int totalRejectionScore;
  final int feedbackId;

  FeedbackResponse({
    required this.conversationId,
    required this.feedbackText,
    required this.finalLikingLevel,
    required this.totalRejectionScore,
    required this.feedbackId,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) => _$FeedbackResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackResponseToJson(this);
}
