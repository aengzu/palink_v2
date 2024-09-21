import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/entities/likability/liking_level.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_end_loading_screen.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'chat_end_loading_viewmodel.dart';

class ChatViewModel extends GetxController {
  final int chatRoomId;
  final Character character;

  final FetchChatHistoryUsecase fetchChatHistoryUsecase = getIt<FetchChatHistoryUsecase>();
  final SendUserMessageUsecase sendMessageUsecase = getIt<SendUserMessageUsecase>();

  TextEditingController textController = TextEditingController();
  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var questStatus = List<bool>.filled(5, false).obs; // 퀘스트 달성 여부를 나타내는 리스트
  var isQuestPopupShown = false.obs;

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

      var responseMap = await sendMessageUsecase.generateAIResponse(chatRoomId, character);
      if (responseMap.isNotEmpty) {
        Message? aiMessage = convertAIResponseToMessage(responseMap.values.first!, responseMap.keys.first!.toString());
        if (aiMessage != null) {
          messages.insert(0, aiMessage); // AI 응답 메시지를 리스트에 추가
        }

        _handleQuestAchievements(responseMap.values.first!); // 퀘스트 달성 확인
        _checkIfConversationEnded(responseMap.values.first!); // 대화 종료 여부 확인
        textController.clear(); // 메시지 입력창 초기화
      } else {
        print('AI 응답이 없습니다');
      }
    } catch (e) {
      print('메시지 전송 실패 :  $e');
    } finally {
      isLoading.value = false;
    }
  }


  // AIResponse를 Message로 변환하는 메서드
  Message? convertAIResponseToMessage(AIResponse aiResponse, String messageId) {
    return Message(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        affinityScore: aiResponse.affinityScore, // 매핑
        rejectionScore: aiResponse.rejectionScore,
        id: messageId, // 매핑
    );
  }

  // 퀘스트 달성을 확인하고 토스트 메시지를 표시하는 메서드
  Future<void> _handleQuestAchievements(AIResponse aiResponse) async {
    if (aiResponse.achievedQuest != null && aiResponse.achievedQuest.isNotEmpty) {
      String achievedQuest = aiResponse.achievedQuest;
      List<String> questNumbers = achievedQuest.split(',');

      for (String quest in questNumbers) {
        Fluttertoast.showToast(
          msg: "퀘스트 $quest 달성!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blue[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
        updateQuestStatus(int.parse(quest) - 1);
      }
    }
  }

  // 대화 종료 여부 확인하는 메서드
  Future<void> _checkIfConversationEnded(AIResponse aiResponse) async {
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

  // 유저가 리액션을 하면 메시지에 reaction 추가하기
  void addReactionToMessage(Message message, String reaction) {
    final updatedReactions = List<String>.from(message.reactions);
    updatedReactions.add(reaction);

    final index = messages.indexOf(message);
    if (index != -1) {
      final updatedMessages = List<Message>.from(messages); // 새로운 리스트 복사
      updatedMessages[index] = message.copyWith(reactions: updatedReactions); // 업데이트된 메시지 적용
      messages.value = updatedMessages; // 새로운 리스트로 할당하여 UI 갱신
    }
  }

  // 대화 첫 진입 시 퀘스트 팝업을 한 번만 띄우는 메서드
  Future<void> showQuestPopupIfFirstTime(BuildContext context) async {
    if (!isQuestPopupShown.value) {
      await _showQuestPopup(context);
      isQuestPopupShown.value = true; // 팝업이 한 번 뜨면 이후에는 뜨지 않도록 설정
    }
  }

  // 퀘스트 팝업 표시 메서드
  Future<void> _showQuestPopup(BuildContext context) async {
    final questInfo = await getQuestInformation();
    await Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${character.name}과 대화 진행 시 퀘스트',
                style: textTheme().titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                '퀘스트는 프로필 상단 우측에 표시됩니다.\n퀘스트를 달성하면 퀘스트 아이콘 옆에 체크 표시가 나타납니다.\n퀘스트를 확인하고 싶다면 프로필을 클릭하세요',
                style: textTheme().bodySmall,
              ),
              const SizedBox(height: 10),
              Text(
                questInfo,
                style: textTheme().bodyMedium,
              ),
              const SizedBox(height: 30),
              CustomButtonMD(
                onPressed: () {
                  Get.back(); // 다이얼로그 닫기
                },
                label: '확인했습니다!',
              ),
            ],
          ),
        ),
      ),
    );
  }

}
