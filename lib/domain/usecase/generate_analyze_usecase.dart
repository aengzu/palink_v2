import 'package:palink_v2/data/models/ai_response/analysis_request.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';

class GenerateAnalyzeUsecase {
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();

  Future<AnalysisResponse?> execute(List<Message> chatHistory) {
    AnalysisRequest input = AnalysisRequest(
      chatHistory: chatHistory.map((e) => e).join(' '),
      quest: 'analysis',
      rejectionContent: '',
    );
    return aiRepository.analyzeResponse(input);
  }
}
