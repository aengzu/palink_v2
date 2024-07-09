import 'package:get/get.dart';
import 'package:palink_v2/controller/tip_viewmodel.dart';
import 'package:palink_v2/controller/user_controller.dart';
import 'package:palink_v2/models/character.dart';
import 'package:palink_v2/models/chat/ai_response.dart';
import 'package:palink_v2/services/chat_service.dart';
import 'package:palink_v2/services/openai_service.dart';
import 'package:palink_v2/utils/message_utils.dart';
import 'package:palink_v2/views/chatting_view/chat_screen.dart';
import 'package:palink_v2/models/chat/conversation.dart';
import '../models/chat/message.dart';
import '../repository/chat_repository.dart';
import 'chatting_viewmodel.dart';

class CharacterLoadingController extends GetxController {
  final Character character;
  final UserController userController = Get.put(UserController());
  final ChatRepository chatRepository = ChatRepository();
  final TipButtonViewModel tipButtonViewModel = TipButtonViewModel();



  CharacterLoadingController(this.character);

  @override
  void onInit() {
    super.onInit();
    _startRolePlaying();
  }

  Future<void> _startRolePlaying() async {
    try {
      ConversationDto conversationDto = ConversationDto(
        day: DateTime.now().toIso8601String(),
        userId: userController.userId.value,
        characterId: character.characterId,
      );

      Conversation conversation = await chatRepository.createConversation(conversationDto);
      OpenAIService openAIService = OpenAIService(character, conversation.conversationId);
      AIResponse aiResponse = await openAIService.proceedRolePlaying() as AIResponse;


      // AI 응답 메시지를 MessageDto로 변환
      MessageDto botMessageDto = MessageUtils.convertAIMessageToMessageDto(aiResponse, conversation.conversationId);
      Message? sentBotMessage = await chatRepository.sendMessage(botMessageDto);


      final chatViewModel = ChatViewModel(conversation.conversationId, character, openAIService);
      if (sentBotMessage != null) {
        chatViewModel.messages.insert(0, sentBotMessage);
      }

      Get.off(() => ChatScreen(viewModel: chatViewModel));
    } catch (e) {
      print('Failed to create conversation or get AI response: $e');
    }
  }
}
