// domain/usecases/generate_response_usecase.dart
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/models/user/user.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';


class GenerateResponseUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();
  final AIRepository aiRepository = getIt<AIRepository>();
  final GetUserInfoUseCase getUserInfoUseCase;
  final FetchChatHistoryUsecase fetchChatHistoryUsecase;

  GenerateResponseUsecase(this.getUserInfoUseCase, this.fetchChatHistoryUsecase);

  Future<AIResponse?> execute(int conversationId, Character character) async {
    // 사용자 정보 가져오기
    User user = await getUserInfoUseCase.execute();

    // AI와의 대화 시작
    final memoryVariables = await aiRepository.getMemory();
    final chatHistory = memoryVariables['history'] ?? '';

    final inputs = {
      'input': '대화를 시작합니다.',
      'chat_history': chatHistory,
      'userName': user.name,
      'description': character.prompt,
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

      await aiRepository.saveMemoryContext(inputs, {'response': aiResponse});
    }
    return aiResponse;
  }
}
