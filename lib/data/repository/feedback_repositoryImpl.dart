
import 'package:palink_v2/data/api/feedback/feedback_api.dart';
import 'package:palink_v2/data/models/feedback/feedback_request.dart';
import 'package:palink_v2/data/models/feedback/feedback_response.dart';
import 'package:palink_v2/data/models/feedback/feedbacks_response.dart';
import 'package:palink_v2/domain/repository/feedback_repository.dart';


class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackApi feedbackApi;

  FeedbackRepositoryImpl(this.feedbackApi);

  @override
  Future<FeedbackResponse> createFeedback(FeedbackRequest feedbackRequest) {
    return feedbackApi.saveFeedback(feedbackRequest);
  }

  @override
  Future<FeedbacksResponse> getFeedbacksByConversationId(int conversationId) {
    return feedbackApi.getFeedbackByConversationId(conversationId);
  }
}

