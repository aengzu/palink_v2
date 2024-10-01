import 'package:palink_v2/data/models/ai_response/analysis_request.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_request.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';
import 'package:palink_v2/data/models/ai_response/tip_request.dart';
import 'package:palink_v2/data/models/ai_response/tip_response.dart';
import 'package:palink_v2/data/service/conversation_analysis_service.dart';
import 'package:palink_v2/data/service/rejection_service.dart';
import 'package:palink_v2/data/service/response_service.dart';
import 'package:palink_v2/data/service/sentiment_service.dart';
import 'package:palink_v2/data/service/sequential_chain.dart';
import 'package:palink_v2/data/service/tip_service.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';

class OpenAIRepositoryImpl implements OpenAIRepository {
  final ConversationAnalysisService conversationAnalysisService =
      ConversationAnalysisService.initialize();
  final TipService tipService = TipService.initialize();
  final SentimentService sentimentAnalysisService =
      SentimentService.initialize();
  final RejectionService rejectionService = RejectionService.initialize();
  final ResponseService responseService = ResponseService.initialize();

  @override
  Future<RejectionResponse?> judgeRejection(String userMessage) {
    return rejectionService.judgeRejection(userMessage);
  }

  // 2024.10.1. 사용 제거
  @override
  Future<LikingResponse?> judgeSentiment(String userMessage, String aiMessage) {
    return sentimentAnalysisService.analyzeSentiment(userMessage, aiMessage);
  }

  @override
  Future<AIMessageResponse?> getChatResponse(AIMessageRequest messageRequest) {
    return responseService.getChatResponse(messageRequest);
  }

  @override
  Future<AnalysisResponse?> analyzeResponse(AnalysisRequest analysisRequest) {
    return conversationAnalysisService.analyzeConversation(analysisRequest);
  }

  @override
  Future<TipResponse?> createTip(TipRequest tipRequest) {
    return tipService.createTip(tipRequest);
  }
}
