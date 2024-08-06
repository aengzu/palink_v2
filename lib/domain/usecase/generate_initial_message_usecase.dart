import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/services/openai_service.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/models/user/user.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';

class CreateInitialMessageUseCase {
  final ChatRepository chatRepository;
  final GetUserInfoUseCase getUserInfoUseCase;

  CreateInitialMessageUseCase(this.chatRepository, this.getUserInfoUseCase);

  Future<AIResponse?> execute(int conversationId, Character character) async {
    // 사용자 정보 가져오기
    User user = await getUserInfoUseCase.execute();

    // AI와의 대화 시작
    var openAIService = OpenAIService(character, conversationId);
    AIResponse? aiResponse = await openAIService.proceedRolePlaying(user);
    print(aiResponse?.text);

    // AI 응답을 메시지로 변환하여 저장
    if (aiResponse != null) {
      var messageRequest = MessageRequest(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        conversationId: conversationId,
      );
      await chatRepository.sendMessage(messageRequest);
    }

    return aiResponse;
  }
}
