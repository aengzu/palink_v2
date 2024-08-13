import 'package:json_annotation/json_annotation.dart';

part 'feedback_request.g.dart';

@JsonSerializable()
class FeedbackRequest {
  final int conversationId;
  final String feedbackText;
  final int finalLikingLevel;
  final int totalRejectionScore;

  FeedbackRequest({
    required this.conversationId,
    required this.feedbackText,
    required this.finalLikingLevel,
    required this.totalRejectionScore,
  });

  factory FeedbackRequest.fromJson(Map<String, dynamic> json) => _$FeedbackRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackRequestToJson(this);
}
