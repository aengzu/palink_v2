import 'package:palink_v2/data/models/feedback/feedbacks_response.dart';
import 'package:palink_v2/domain/model/analysis/feedback.dart';
import 'package:palink_v2/domain/repository/feedback_repository.dart';

class GetFeedbackByConversationUsecase {
  final FeedbackRepository feedbackRepository;
  GetFeedbackByConversationUsecase(this.feedbackRepository);

  Future<Feedback> execute(int conversationId) async {
    FeedbacksResponse response = await feedbackRepository.getFeedbacksByConversationId(conversationId);
    return response.toDomain();
  }
}
