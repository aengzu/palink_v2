import 'package:palink_v2/data/models/ai_response/ai_message_request.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';
import 'package:palink_v2/data/models/ai_response/analysis_request.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';
import 'package:palink_v2/data/models/ai_response/tip_request.dart';
import 'package:palink_v2/data/models/ai_response/tip_response.dart';



abstract class OpenAIRepository {
  Future<AIMessageResponse?> getChatResponse(AIMessageRequest messageRequest);
  Future<RejectionResponse?> judgeRejection(String userMessage);
  Future<LikingResponse?> judgeSentiment(String userMessage, String aiMessage);
  Future<TipResponse?> createTip(TipRequest tipRequest);
  Future<AnalysisResponse?> analyzeResponse(AnalysisRequest analysisRequest);
}
