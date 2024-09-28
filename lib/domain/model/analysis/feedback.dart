class Feedback {
  final int conversationId;
  final String feedbackText;
  final int finalLikingLevel;
  final int totalRejectionScore;

  Feedback({
    required this.conversationId,
    required this.feedbackText,
    required this.finalLikingLevel,
    required this.totalRejectionScore,
  });
}
