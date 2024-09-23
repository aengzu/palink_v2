import 'package:palink_v2/data/models/feedback/feedback_request.dart';
import 'package:palink_v2/data/models/feedback/feedback_response.dart';
import 'package:palink_v2/data/models/feedback/feedbacks_response.dart';

abstract class FeedbackRepository {
  Future<FeedbackResponse> createFeedback(FeedbackRequest feedbackRequest);
  Future<FeedbacksResponse> getFeedbacksByConversationId(int conversationId);
}
