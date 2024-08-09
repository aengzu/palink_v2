import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class GenerateInitialMessageUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();
  final AIRepository aiRepository = getIt<AIRepository>();

  GenerateInitialMessageUsecase();

  Future<AIResponse?> execute(int conversationId, String userName,
      String description) async {
    final memoryVariables = await aiRepository.getMemory();
    final chatHistory = memoryVariables['history'] ?? '';

    final inputs = {
      'input': '당신이 먼저 부탁을 하며 대화를 시작하세요.',
      'chat_history': chatHistory,
      'userName': userName,
      'description': description,
      'conversationId': conversationId.toString(),
    };

    AIResponse? aiResponse = await aiRepository.processChat(inputs);
    // AI 응답을 메시지로 변환하여 저장
    if (aiResponse != null) {
      var messageRequest = MessageRequest(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        conversationId: conversationId,
      );
      await chatRepository.saveMessage(messageRequest);

      if (aiResponse != null) {
        await aiRepository.saveMemoryContext(inputs, {'response': aiResponse});
      }

      return aiResponse;
    }
  }
}
