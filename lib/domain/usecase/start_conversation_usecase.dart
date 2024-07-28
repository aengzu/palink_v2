import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/services/openai_service.dart';
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/user.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';


class StartConversationUseCase {
  final ChatRepository chatRepository;
  final GetUserInfoUseCase getUserInfoUseCase;

  StartConversationUseCase(this.chatRepository, this.getUserInfoUseCase);

  Future<AIResponse?> execute(Character character) async {
    // GetUserUseCase를 사용하여 사용자 정보 가져오기
    User user = await getUserInfoUseCase.execute();
    print('User: $user');

    // 대화 생성
    var conversationRequest = ConversationRequest(
      day: DateTime.now().toIso8601String(),
      userId: user.userId,
      characterId: character.characterId,
    );
    Conversation conversation = await chatRepository.createConversation(conversationRequest);

    print('Conversation: $conversation');
    // AI와의 대화 시작
    var openAIService = OpenAIService(character, conversation.conversationId);
    print('OpenAIService: $openAIService');
    AIResponse? aiResponse = await openAIService.proceedRolePlaying(user);
    print(aiResponse?.text);

    // AI 응답을 메시지로 변환하여 저장
    if (aiResponse != null) {
      var messageRequest = MessageRequest(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        conversationId: conversation.conversationId,
      );
      await chatRepository.sendMessage(messageRequest);
    }

    return aiResponse;
  }
}
