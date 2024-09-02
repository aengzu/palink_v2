import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/entities/likability/liking_level.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_end_loading_screen.dart';
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
  var questStatus = List<bool>.filled(5, false).obs; // 퀘스트 달성 여부를 나타내는 리스트

  ChatViewModel({
    required this.chatRoomId,
    required this.character,
  });

  void updateQuestStatus(int questIndex) {
    if (questIndex >= 0 && questIndex < questStatus.length) {
      questStatus[questIndex] = true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadMessages(); // 첫 AI 메시지를 화면에 로드
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  // 채팅 기록을 가져오는 메서드
  Future<void> _loadMessages() async {
    isLoading.value = true;
    try {
      var loadedMessages = await fetchChatHistoryUsecase.execute(chatRoomId); // 채팅 기록 가져오기
      messages.value = loadedMessages!.reversed.toList(); // 메시지를 역순으로 리스트에 추가
    } catch (e) {
      print('Failed to load messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 메시지 전송 메서드
  Future<void> sendMessage() async {
    if (textController.text.isEmpty) return;
    isLoading.value = true;
    try {
      var userMessage = await sendMessageUsecase.saveUserMessage(textController.text, chatRoomId);
      if (userMessage != null) {
        messages.insert(0, userMessage); // 사용자 메시지를 리스트에 추가
      }

      var aiResponseMessage = await sendMessageUsecase.generateAIResponse(chatRoomId, character);
      if (aiResponseMessage != null) {
        var aiMessage = convertAIResponseToMessage(aiResponseMessage);
        if (aiMessage != null) {
          messages.insert(0, aiMessage); // AI 응답 메시지를 리스트에 추가
        }
      } else {
        print('AI 응답이 없습니다');
      }

      _loadMessages(); // 메시지 로드

      _handleQuestAchievements(aiResponseMessage!); // 퀘스트 달성 확인
      _checkIfConversationEnded(aiResponseMessage!); // 대화 종료 여부 확인
      textController.clear(); // 메시지 입력창 초기화
    } catch (e) {
      print('메시지 전송 실패 :  $e');
    } finally {
      isLoading.value = false;
    }
  }


  // AIResponse를 Message로 변환하는 메서드
  Message? convertAIResponseToMessage(AIResponse aiResponse) {
    return Message(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        affinityScore: aiResponse.affinityScore, // 매핑
        rejectionScore: aiResponse.rejectionScore // 매핑
    );
  }

  // 퀘스트 달성을 확인하고 토스트 메시지를 표시하는 메서드
  void _handleQuestAchievements(AIResponse aiResponse) {
    if (aiResponse.achievedQuest != null) {
      String achievedQuest = aiResponse.achievedQuest;
      List<String> questNumbers = achievedQuest.split(',');

      for (String quest in questNumbers) {
        Fluttertoast.showToast(
          msg: "퀘스트 $quest 달성!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        updateQuestStatus(int.parse(quest) - 1);
      }
    }
  }

  // 대화 종료 여부 확인하는 메서드
  void _checkIfConversationEnded(AIResponse aiResponse) {
    if (aiResponse.isEnd == 1) {
      navigateToChatEndScreen();
    }
  }

  // 대화 종료 화면으로 이동하는 메서드
  void navigateToChatEndScreen() {
    Get.off(() => ChatEndLoadingView(
        chatEndLoadingViewModel: Get.put(ChatEndLoadingViewModel(
            character: character, chatHistory: messages.toList()))));
  }

  // 퀘스트 정보를 가져오는 메서드
  Future<String> getQuestInformation() async {
    return character.quest;
  }


}
