import 'package:get/get.dart';
import 'package:palink_v2/controller/conversation_end_controller.dart';
import 'package:palink_v2/controller/tip_viewmodel.dart';
import 'package:palink_v2/models/chat/ai_response.dart';
import 'package:palink_v2/models/chat/message.dart';
import 'package:palink_v2/services/chat_service.dart';
import 'package:palink_v2/services/openai_service.dart';
import 'package:palink_v2/controller/user_controller.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/emotion_vibration.dart';
import '../models/likability.dart';
import '../models/liking_level.dart';
import '../repository/chat_repository.dart';
import '../utils/message_utils.dart';
import '../views/chatting_view/conversation_end_loading.dart';
import 'package:vibration/vibration.dart';

class ChatViewModel extends GetxController {
  final int chatRoomId;
  final Character character;
  final OpenAIService  openAIService;
  final UserController userController = Get.put(UserController());
  final EmotionVibration emotionVibration = EmotionVibration();

  final ChatRepository chatRepository = ChatRepository();
  TextEditingController textController = TextEditingController();

  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var likingLevels = <LikingLevel>[].obs;
  var tipContent = ''.obs;
  var backgroundColor = Colors.white.obs;

  ChatViewModel(this.chatRoomId, this.character, this.openAIService);

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
      List<Message> list = await chatRepository.getMessagesByChatRoomId(chatRoomId);
      messages.value = list;
    } catch (e) {
      print('Failed to load messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    String text = textController.text;
    if (text.isEmpty) return;

    try {
      // 사용자 메시지
      Message? sentUserMessage = await chatRepository.sendUserMessage(text, chatRoomId);
      if (sentUserMessage != null) {
        messages.insert(0, sentUserMessage); // 사용자 메시지 화면에 표시
        likingLevels.insert(0, LikingLevel(likingLevel: 0, messageId: sentUserMessage.messageId)); // 더미 호감도 저장
      }

      // AI 메시지
      AIResponse? aiResponse = await openAIService.invokeChain(text); // ai로 text 넣어서 응답받는거
      if (aiResponse != null) {
        MessageDto botMessageDto = MessageUtils.convertAIMessageToMessageDto(aiResponse, chatRoomId);
        Message? sentBotMessage = await chatRepository.sendMessage(botMessageDto);

        // 여기에 aiResponse의 isEnd 값확인하고, 1이면 종료
        // 대화 종료 체크
        if (aiResponse.isEnd == 1) {
          print('호감도: ${aiResponse.affinityScore}');
          ConversationEndController conversationEndController = ConversationEndController(character, messages, chatRoomId, aiResponse.affinityScore);
          Get.to(() => ConversationEndLoadingView(controller: conversationEndController));
          await conversationEndController.invokeAnalyze();
          return;
        }

        if (sentBotMessage != null) {
          messages.insert(0, sentBotMessage); // 받은 AI 메시지 화면에 표시
          // ai의 호감도 화면에 표시
          likingLevels.insert(0, LikingLevel(
              likingLevel: aiResponse.affinityScore, messageId: sentBotMessage.messageId) as LikingLevel);
          // AI의 감정에 따른 배경색 변경
          print(aiResponse.expectedEmotion);
          backgroundColor.value = emotionVibration.getColorForEmotion(aiResponse.expectedEmotion);
          // AI의 감정에 따른 진동 실행
          emotionVibration.vibrateForEmotion(aiResponse.expectedEmotion);
          // 호감도 db 서버에 전송하기
          chatRepository.sendLikingLevel(
              userController.userId.value, character.characterId,
              aiResponse.affinityScore, sentBotMessage.messageId);
          // 팁 업데이트
          Map? tipResponse = await openAIService.invokeTip(aiResponse);

          if (tipResponse != null) {
            tipContent.value = tipResponse['answer'];
            print(tipContent.value);
          }
        }
      }
    } catch (e) {
      print('Failed to send message: $e');
    } finally {
      textController.clear();
    }
  }

  void analyzeMessage() async {
    // 메시지 분석
    // 메시지에 대한 호감도 업데이트
    // 팁 업데이트
  }
}
