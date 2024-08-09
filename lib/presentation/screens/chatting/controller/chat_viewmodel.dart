import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_end_loading_screen.dart';
import '../../../../domain/models/likability/liking_level.dart';
import 'chat_end_loading_viewmodel.dart';

class ChatViewModel extends GetxController {
  final int chatRoomId;
  final Character character;

  final FetchChatHistoryUsecase fetchChatHistoryUsecase = getIt<FetchChatHistoryUsecase>();
  final SendUserMessageUsecase sendMessageUsecase = getIt<SendUserMessageUsecase>();

  TextEditingController textController = TextEditingController();
  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var likingLevels = <LikingLevel>[].obs;
  var backgroundColor = Colors.white.obs;


  ChatViewModel({
    required this.chatRoomId,
    required this.character,
  });

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  Future<void> _loadMessages() async {
    isLoading.value = true;
    try {
      var loadedMessages = await fetchChatHistoryUsecase.execute(chatRoomId);
      messages.value = loadedMessages.reversed.toList(); // 역순으로 정렬
      print('Loaded messages: $messages');
    } catch (e) {
      print('Failed to load messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    if (textController.text.isEmpty) return;
    isLoading.value = true;
    try {
      var userMessage = await sendMessageUsecase.saveUserMessage(textController.text, chatRoomId);
      if (userMessage != null) {
        messages.insert(0, userMessage); // 사용자 메시지를 리스트에 추가
      }

      var aiResponseMessage = await sendMessageUsecase.generateAIResponse(chatRoomId, character);


      var aiMessage = convertAIResponseToMessage(aiResponseMessage!);
      if (aiMessage != null) {
        messages.insert(0, aiMessage); // AI 응답 메시지를 리스트에 추가
      }

      _handleConversationEnd(aiResponseMessage);

      textController.clear();
    } catch (e) {
      print('Failed to send message: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Message? convertAIResponseToMessage(AIResponse aiResponse) {
    return Message(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        affinityScore: aiResponse.affinityScore, // 매핑
        rejectionScore: aiResponse.rejectionScore // 매핑
    );
  }
  void _handleConversationEnd(AIResponse aiResponse) {
    if (aiResponse.isEnd == 1) {
      Get.off(() => ChatEndLoadingView(chatEndLoadingViewModel: Get.put(ChatEndLoadingViewModel(character: character, chatHistory: messages.toList()))));
    }
  }

}
