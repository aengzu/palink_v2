import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/tip/tip_dto.dart';


abstract class AIRepository {
  Future<Map<String, dynamic>> getMemory();
  Future<void> saveMemoryContext(Map<String, dynamic> inputValues, Map<String, dynamic> outputValues);
  Future<AIResponse?> processChat(Map<String, dynamic> inputs);
  Future<TipDto?> getTip(Message message);
  Future<Map?> analyzeResponse(String input);
}
