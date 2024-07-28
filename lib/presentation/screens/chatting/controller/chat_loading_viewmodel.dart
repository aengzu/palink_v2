import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';
import 'package:palink_v2/domain/usecase/start_conversation_usecase.dart';
import 'package:palink_v2/domain/usecase/get_message_usecase.dart';
import 'package:palink_v2/domain/usecase/send_message_usecase.dart';
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_screen.dart';
import 'chat_viewmodel.dart';

class ChatLoadingViewModel extends GetxController {
  final StartConversationUseCase startConversationUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final Character character;

  ChatLoadingViewModel({
    required this.startConversationUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.getUserInfoUseCase,
    required this.character,
  });

  @override
  void onInit() {
    print('ChatLoadingViewModel onInit');
    super.onInit();
    _startRolePlaying();
  }

  Future<void> _startRolePlaying() async {
    try {
      AIResponse? aiResponse = await startConversationUseCase.execute(character);
      if (aiResponse != null) {
        Get.off(() => ChatScreen(viewModel: ChatViewModel(
          chatRoomId: aiResponse.conversationId,
          character: character,
          getMessagesUseCase: getMessagesUseCase,
          sendMessageUseCase: sendMessageUseCase,
        )));
      }
    } catch (e) {
      print('Failed to start role-playing: $e');
    }
  }
}
