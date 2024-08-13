import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/data/models/feedback/feedback_response.dart';
part 'feedbacks_response.g.dart';

@JsonSerializable()
class FeedbacksResponse {
  final List<FeedbackResponse> feedbacks;

  FeedbacksResponse({required this.feedbacks});

  factory FeedbacksResponse.fromJson(Map<String, dynamic> json) => _$FeedbacksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbacksResponseToJson(this);
}
