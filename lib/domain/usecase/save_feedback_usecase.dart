import 'package:palink_v2/data/models/feedback/feedback_request.dart';
import 'package:palink_v2/domain/repository/feedback_repository.dart';
import 'package:palink_v2/di/locator.dart';

class SaveFeedbackUseCase {
  final FeedbackRepository feedbackRepository = getIt<FeedbackRepository>();

  Future<void> execute({
    required int conversationId,
    required String feedbackText,
    required int finalLikingLevel,
    required int totalRejectionScore,
  }) async {
    try {
      // Creating feedback request
      FeedbackRequest feedbackRequest = FeedbackRequest(
        conversationId: conversationId,
        feedbackText: feedbackText,
        finalLikingLevel: finalLikingLevel,
        totalRejectionScore: totalRejectionScore,
      );

      // Submitting feedback to the repository
      await feedbackRepository.createFeedback(feedbackRequest);
      print('Feedback submitted successfully.');
    } catch (e) {
      print('Failed to submit feedback: $e');
    }
  }
}
