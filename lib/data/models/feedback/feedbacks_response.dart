import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/domain/model/analysis/feedback.dart';
import 'feedback_response.dart';

part 'feedbacks_response.g.dart';

@JsonSerializable()
class FeedbacksResponse {
  final List<FeedbackResponse> feedbacks;

  FeedbacksResponse({required this.feedbacks});

  factory FeedbacksResponse.fromJson(Map<String, dynamic> json) => _$FeedbacksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbacksResponseToJson(this);

  // 하나의 feedback만 가져오는 메서드
  Feedback toDomain() {
    return feedbacks.isNotEmpty ? feedbacks.first.toDomain() : throw Exception('No feedbacks available');
  }
}
