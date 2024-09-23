import 'package:palink_v2/data/models/ai_response/analysis_request.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';

class GenerateAnalyzeUsecase {
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();

  Future<AnalysisResponse?> execute(String chatHistory, String unachievedQuests, int finalRejectionScore) async {

    AnalysisRequest input = AnalysisRequest(
      chatHistory: chatHistory,
      quest: unachievedQuests,
      finalRejectionScore: finalRejectionScore,
    );

    return aiRepository.analyzeResponse(input);
  }
}
