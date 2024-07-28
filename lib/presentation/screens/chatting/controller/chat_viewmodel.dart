import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/usecase/get_message_usecase.dart';
import 'package:palink_v2/domain/usecase/send_message_usecase.dart';
import 'package:palink_v2/domain/models/character.dart';

class ChatViewModel extends GetxController {
  final int chatRoomId;
  final Character character;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  TextEditingController textController = TextEditingController();
  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var backgroundColor = Colors.white.obs;
  var tipContent = ''.obs; // tipContent 속성 추가

  ChatViewModel({
    required this.chatRoomId,
    required this.character,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  Future<void> loadMessages() async {
    isLoading.value = true;
    try {
      messages.value = await getMessagesUseCase.execute(chatRoomId);
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
      await sendMessageUseCase.execute(textController.text, chatRoomId);
      textController.clear();
      loadMessages(); // 메시지 목록 업데이트
      // 필요한 경우 tipContent 업데이트
      updateTipContent();
    } catch (e) {
      print('Failed to send message: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateTipContent() {
    // 실제 구현에서는 대화 내용에 따라 tipContent 업데이트 로직을 구현
    tipContent.value = "대화할 때 예의를 지키세요!";
  }
}
