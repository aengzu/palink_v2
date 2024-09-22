import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
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

      var responseMap = await sendMessageUsecase.generateAIResponse(chatRoomId, character, getUnachievedQuests());
      if (responseMap.isNotEmpty) {
        Message? aiMessage = convertAIResponseToMessage(responseMap.values.first!, responseMap.keys.first!.toString());
        AIResponse response = responseMap.values.first!;
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
        affinityScore: 50 + aiResponse.affinityScore, // 매핑
        rejectionScore: aiResponse.rejectionScore,
        id: messageId, // 매핑
    );
  }

  // 대화 종료 여부 확인하는 메서드
  Future<void> _checkIfConversationEnded(AIResponse aiResponse) async {
    if (aiResponse.finalRejectionScore < -5) {
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
  // 퀘스트 달성을 확인하고 퀘스트 내용을 표시하는 메서드
  Future<void> _handleQuestAchievements(AIResponse aiResponse) async {
    if (aiResponse.rejectionContent != null && aiResponse.rejectionContent.isNotEmpty) {
      for (int questIndex = 0; questIndex < questContentMap[character.name]!.length; questIndex++) {
        bool isQuestAchieved = _isQuestAchieved(questIndex, aiResponse);
        if (isQuestAchieved && !questStatus[questIndex]) {
          updateQuestStatus(questIndex);
          String questContent = questContentMap[character.name]?[questIndex] ?? '알 수 없는 퀘스트';

          // 퀘스트 달성 메시지 출력
          Fluttertoast.showToast(
            msg: "퀘스트 달성! $questContent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP_RIGHT,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.blue[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    }
  }

  // 퀘스트 달성 여부를 판단하는 메서드
  bool _isQuestAchieved(int questIndex, AIResponse aiResponse) {
    List<String> rejectionContent = aiResponse.rejectionContent;
    List<String> questConditions = questConditionMap[character.name]?[questIndex] ?? [];

    // 퀘스트 달성 조건 중 하나라도 만족하면 true 반환
    return questConditions.any((condition) => rejectionContent.contains(condition));
  }

  // 캐릭터별 퀘스트 내용을 정의한 맵
  final Map<String, List<String>> questContentMap = {
    '미연': [
      '10회 안에 거절 성공하기',
      '상대방이 처한 상황을 파악하기 위한 대화 시도하기',
      '상대방의 감정에 대한 공감 표현하기',
      '도와주지 못하는 합리적인 이유 제시하기',
      '서로 양보해서 절충안 찾아보기',
    ],
    '세진': [
      '8회 안에 거절 성공하기',
      '이전 도움에 대한 감사 표현하기',
      '감정적인 요소를 포함하여 거절하기',
      '도와주지 못하는 합리적인 이유 제시하기',
      '서로 양보해서 절충안 찾아보기',
    ],
    '현아': [
      '7회 안에 거절 성공하기',
      '시간 제한을 두고 거절하기',
      '상대방의 부탁에 대해 존중 표현하기',
      '도와주지 못하는 합리적인 이유 제시하기',
      '집요한 요청에 대한 의사 표현하기',
    ],
    '진혁': [
      '6회 안에 거절 성공하기',
      '거절 의사 명확히 표현하기',
      '상대방의 욕구를 고려하지 않는 대화 전략 사용하기',
      '상대방에게 감정적으로 대하지 않기',
      '상대방의 무례에 대한 불편함 명확히 표현하기',
    ],
  };

  // 캐릭터별 퀘스트 조건을 정의한 맵 (거절 카테고리와 매핑)
  final Map<String, List<List<String>>> questConditionMap = {
    '미연': [
      [],  // 퀘스트 1: 10회 안에 거절 성공하기 (특정 거절 카테고리 없음)
      ['부탁 내용 확인'],  // 퀘스트 2
      ['아쉬움 표현'],  // 퀘스트 3
      ['거절해야 하는 상황 설명'],  // 퀘스트 4
      ['대안 제시'],  // 퀘스트 5
    ],
    '세진': [
      [],  // 퀘스트 1: 8회 안에 거절 성공하기
      ['과거 배려에 대한 감사함 표시'],  // 퀘스트 2
      ['수락하지 못함에 대한 아쉬움 표현'],  // 퀘스트 3
      ['이유 있는 거절'],  // 퀘스트 4
      ['대안 제시'],  // 퀘스트 5
    ],
    '현아': [
      [],  // 퀘스트 1: 7회 안에 거절 성공하기
      ['시간 제한'],  // 퀘스트 2
      ['상황에 대한 공감'],  // 퀘스트 3
      ['이유 있는 거절'],  // 퀘스트 4
      ['단호한 거절'],  // 퀘스트 5
    ],
    '진혁': [
      [],  // 퀘스트 1: 6회 안에 거절 성공하기
      ['단호한 거절'],  // 퀘스트 2
      [],  // 퀘스트 3: 특정 조건 없음
      [],  // 퀘스트 4: 특정 조건 없음
      [],  // 퀘스트 5: 특정 조건 없음
    ],
  };

  // 미달성 퀘스트 리스트를 반환하는 메서드
  List<String> getUnachievedQuests() {
    List<String> unachievedQuests = [];
    for (int i = 0; i < questStatus.length; i++) {
      if (!questStatus[i]) {
        unachievedQuests.add(questContentMap[character.name]?[i] ?? '알 수 없는 퀘스트');
      }
    }
    return unachievedQuests;
  }

}
