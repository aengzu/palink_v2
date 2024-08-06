import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/usecase/generate_initial_message_usecase.dart';
import 'package:palink_v2/domain/usecase/create_conversation_usecase.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_screen.dart';
import 'package:palink_v2/domain/models/user/user.dart';
import 'package:palink_v2/domain/usecase/get_user_info_usecase.dart';

class ChatLoadingViewModel extends GetxController {
  final CreateConversationUseCase createConversationUseCase = getIt<CreateConversationUseCase>();
  final GenerateInitialMessageUsecase generateInitialMessageUsecase = getIt<GenerateInitialMessageUsecase>();
  final GetUserInfoUseCase getUserInfoUseCase = getIt<GetUserInfoUseCase>();

  final Character character;
  var conversation = Rxn<Conversation>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var user = Rxn<User>();

  ChatLoadingViewModel({required this.character});

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      user.value = await getUserInfoUseCase.execute();
      await _createConversationAndInitialMessage();
    } catch (e) {
      print('Initialization failed: $e');
      errorMessage.value = 'Initialization failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createConversationAndInitialMessage() async {
    try {
      // Create Conversation
      conversation.value = await _createConversation();
      if (conversation.value != null && user.value != null) {
        final conversationId = conversation.value!.conversationId;

        // Generate Initial Message
        await _createInitialMessage(conversationId, user.value!.name);

        // Navigate to ChatScreen
        Get.off(() => ChatScreen(viewModel: Get.put(ChatViewModel(chatRoomId: conversationId, character: character))));
      }
    } catch (e) {
      print('Failed to create conversation and initial message: $e');
      errorMessage.value = 'Failed to create conversation and initial message: $e';
    }
  }

  Future<Conversation?> _createConversation() async {
    try {
      return await createConversationUseCase.execute(character);
    } catch (e) {
      print('Failed to create conversation: $e');
      errorMessage.value = 'Failed to create conversation: $e';
      return null;
    }
  }

  Future<AIResponse?> _createInitialMessage(int conversationId, String userName) async {
    try {
      AIResponse? aiResponse = await generateInitialMessageUsecase.execute(conversationId, userName, character.prompt);
      if (aiResponse == null) {
        throw Exception('No response from AI.');
      }
      return aiResponse;
    } catch (e) {
      print('Failed to create initial message: $e');
      errorMessage.value = 'Failed to create initial message: $e';
      return null;
    }
  }
}
