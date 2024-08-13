import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/domain/entities/analysis/analysis_dto.dart';
import '../../data/models/tip/tip_dto.dart';



abstract class OpenAIRepository {
  Future<Map<String, dynamic>> getMemory();
  Future<void> saveMemoryContext(Map<String, dynamic> inputValues, Map<String, dynamic> outputValues);
  Future<AIResponse?> processChat(Map<String, dynamic> inputs);
  Future<TipDto?> createTip(String message);
  Future<AnalysisDto?> analyzeResponse(String input);
}
