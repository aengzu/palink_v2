import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/mindset/mindset_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/domain/usecase/send_user_message_usecase.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_end_loading_screen.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'chat_end_loading_viewmodel.dart';

class ChatViewModel extends GetxController {
  final int chatRoomId;
  final Character character;

  final FetchChatHistoryUsecase fetchChatHistoryUsecase =
      getIt<FetchChatHistoryUsecase>();
  final SendUserMessageUsecase sendMessageUsecase =
      getIt<SendUserMessageUsecase>();
  final GetRandomMindsetUseCase getRandomMindsetUseCase =
      getIt<GetRandomMindsetUseCase>();

  TextEditingController textController = TextEditingController();
  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var questStatus = List<bool>.filled(5, false).obs; // 퀘스트 달성 여부를 나타내는 리스트
  var isQuestPopupShown = false.obs;
  var unachievedQuests = <String>[].obs;
  // "단호한 거절" 횟수를 누적할 변수 추가
  var firmRejectionCount = 0.obs;

  var aiResponse;
  var isEnd;
  var messageId;

  // 대화 개수를 체크하기 위한 변수
  var chatCount = 0.obs;

  ChatViewModel({
    required this.chatRoomId,
    required this.character,
  });


  // 퀘스트 달성 상태 업데이트
  void updateQuestStatus(int questIndex) {
    if (questIndex >= 0 && questIndex < questStatus.length) {
      questStatus[questIndex] = true;
      updateUnachievedQuests();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadMessages(); // 첫 AI 메시지를 화면에 로드
    updateUnachievedQuests(); // 미달성 퀘스트 초기화
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
      var loadedMessages =
          await fetchChatHistoryUsecase.execute(chatRoomId); // 채팅 기록 가져오기
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
      var userMessage = await sendMessageUsecase.saveUserMessage(
          textController.text, chatRoomId);
      if (userMessage != null) {
        messages.insert(0, userMessage); // 사용자 메시지를 리스트에 추가
      }

      var responseMap = await sendMessageUsecase.generateAIResponse(
          chatRoomId, character, getUnachievedQuests());

      aiResponse = responseMap['aiResponse'] as AIResponse;
      isEnd = responseMap['isEnd'] as bool;
      messageId = responseMap['messageId'] as int?;

      if (responseMap.isNotEmpty) {
        Message? aiMessage =
            convertAIResponseToMessage(aiResponse!, messageId.toString());
        if (aiMessage != null) {
          messages.insert(0, aiMessage); // AI 응답 메시지를 리스트에 추가
        }
        chatCount.value += 1;

        // "단호한 거절" 카테고리 카운트 업데이트
        if (aiResponse.rejectionContent.contains('단호한 거절')) {
          firmRejectionCount.value += 1;
        }

        _handleQuestAchievements(aiResponse!); // aiResponse
        _checkIfConversationEnded(aiResponse, isEnd); // 대화 종료 여부 확인
        textController.clear(); // 메시지 입력창 초기화
        // 조건을 체크하고 토스트 메시지 띄우기
        checkQuestGuideConditions();
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
      affinityScore: 50 + aiResponse.affinityScore,
      feeling: aiResponse.feeling,
      rejectionScore: aiResponse.rejectionScore,
      id: messageId, // 매핑
    );
  }

  // 대화 종료 여부 확인하는 메서드
  Future<void> _checkIfConversationEnded(
      AIResponse aiResponse, bool isEnd) async {
    int requiredChats = _getRequiredChatLimitsForCharacter(character.name);
    debugPrint('Required Chats: ${requiredChats}');
    // 캐릭터별 제한된 대화 횟수를 넘었거나 AI 응답에서 isEnd가 true일 경우
    if (chatCount.value > requiredChats ||
        isEnd ||
        questStatus[0]
       ) {
      var fetchedMindset = await getRandomMindsetUseCase.execute();

      // 3초 대기
      await Future.delayed(const Duration(seconds: 2));

      // 대화 종료 화면으로 이동
      navigateToChatEndScreen(fetchedMindset!);
    }
  }

  // 대화 종료 화면으로 이동하는 메서드
  void navigateToChatEndScreen(MindsetResponse fetchedMindset) {
    Get.off(() => ChatEndLoadingView(
        chatEndLoadingViewModel: Get.put(ChatEndLoadingViewModel(
            mindset: fetchedMindset,
            character: character,
            finalRejectionScore: aiResponse.finalRejectionScore,
            finalAffinityScore: aiResponse.affinityScore,
            unachievedQuests: getUnachievedQuests(),
            conversationId: chatRoomId))));
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
      updatedMessages[index] =
          message.copyWith(reactions: updatedReactions); // 업데이트된 메시지 적용
      messages.value = updatedMessages; // 새로운 리스트로 할당하여 UI 갱신
    }
  }

  // 대화 첫 진입 시 퀘스트 팝업을 한 번만 띄우는 메서드
  Future<void> showQuestPopupIfFirstTime(BuildContext context) async {
    if (!isQuestPopupShown.value) {
      await showQuestPopup(context);
      isQuestPopupShown.value = true; // 팝업이 한 번 뜨면 이후에는 뜨지 않도록 설정
    }
  }

  // 퀘스트 팝업 표시 메서드
  Future<void> showQuestPopup(BuildContext context) async {
    // 퀘스트 정보를 가져옵니다.
    final questInfo = await getQuestInformation();
    // 퀘스트 문자열을 '\n'으로 분리하여 리스트로 변환
    List<String> questItems = questInfo.split('\n');

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
              // 퀘스트 리스트 표시
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: questItems.map((quest) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Icon(
                          questStatus[questItems.indexOf(quest)] // 해당 퀘스트의 달성 상태 확인
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: questStatus[questItems.indexOf(quest)]
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            quest,
                            maxLines: null, // 최대 줄 수 제한 없음
                            overflow: TextOverflow.visible, // 넘치는 텍스트를 표시
                            style: questStatus[questItems.indexOf(quest)]
                                ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black,
                            )
                                : const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
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
    if (aiResponse.rejectionContent != null &&
        aiResponse.rejectionContent.isNotEmpty) {
      // 퀘스트 1~4를 먼저 처리
      for (int questIndex = 1;
      questIndex < questContentMap[character.name]!.length;
      questIndex++) {

        bool isQuestAchieved = _isQuestAchieved(questIndex, aiResponse);
        if (isQuestAchieved && !questStatus[questIndex]) {
          updateQuestStatus(questIndex);
          String questContent =
              questContentMap[character.name]?[questIndex] ?? '알 수 없는 퀘스트';

          // 퀘스트 달성 메시지 출력
          Get.snackbar(
            "퀘스트 달성!",
            "퀘스트 달성! $questContent",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.blue[700],
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );

          // 퀘스트 2, 3, 4, 5가 모두 달성되었는지 확인
          if (areMainQuestsAchieved()) {
            // 대화 종료 로직 (예: 대화 종료 화면으로 이동)
            var fetchedMindset = await getRandomMindsetUseCase.execute();
            await Future.delayed(const Duration(seconds: 2));
            navigateToChatEndScreen(fetchedMindset!);
          }
        }
      }

      // 퀘스트 0을 마지막에 처리
      if (_isQuestAchieved(0, aiResponse) && !questStatus[0]) {
        updateQuestStatus(0);
        String questContent = questContentMap[character.name]?[0] ?? '알 수 없는 퀘스트';

        // 퀘스트 0번 달성 메시지 출력
        Get.snackbar(
          "퀘스트 달성!",
          "퀘스트 달성! $questContent",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue[700],
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }


  // 퀘스트 달성 여부를 판단하는 메서드
  bool _isQuestAchieved(int questIndex, AIResponse aiResponse) {
    List<String> rejectionContent = aiResponse.rejectionContent;
    List<String> questConditions =
        questConditionMap[character.name]?[questIndex] ?? [];

    // "단호한 거절"이 2회 이상 발생하면 "반복된 요청에 재차 단호한 거절"을 리스트에 추가
    if (firmRejectionCount.value >= 2 && !rejectionContent.contains('반복된 요청에 재차 단호한 거절')) {
      rejectionContent.add('반복된 요청에 재차 단호한 거절');
    }

    // 퀘스트 1: 다른 퀘스트(1-4)가 모두 달성된 경우에만 처리
    if (questIndex == 0) {
      // 다른 모든 퀘스트(1-4)가 달성되었는지 확인
      for (int i = 1; i <= 4; i++) {
        if (!_isQuestAchieved(i, aiResponse)) {
          return false; // 하나라도 달성되지 않았다면 퀘스트 0을 달성할 수 없음
        }
      }
    }

    // 부정적인 거절 카테고리들
    const negativeRejectionCategories = ["티나는 거짓말", "욕설 또는 인신공격", "거절 승낙", "무시하거나 냉담한 반응", "비꼬는 태도", "이유 없는 거절", "주제에서 벗어난 말", "세 글자 이하의 성의없는 답변", "원인을 상대로 돌리기"];

    // 거절 카테고리 중 부정적인 카테고리가 포함된 경우 퀘스트 달성 방지
    if (rejectionContent
        .any((category) => negativeRejectionCategories.contains(category))) {
      return false;
    }

    // 퀘스트 달성 조건 중 하나라도 만족하면 true 반환
    return questConditions
        .any((condition) => rejectionContent.contains(condition));
  }

  // 캐릭터별 퀘스트 내용을 정의한 맵
  final Map<String, List<String>> questContentMap = {
    '미연': [
      '거절 성공하기',
      '상대방이 처한 상황을 파악하기 위한 대화 시도',
      '상대방의 감정에 대한 공감 표현 하기',
      '도와주지 못하는 합리적인 이유 제시',
      '서로 양보해서 절충안 찾기',
    ],
    '세진': [
      '거절 성공하기',
      '이전 도움에 대한 감사 표현하기',
      '감정적인 요소를 포함하여 거절하기',
      '도와주지 못하는 합리적인 이유 제시',
      '서로 양보해서 절충안 찾기',
    ],
    '현아': [
      '거절 성공하기',
      '시간이 부족하다고 말하기',
      '상대방의 부탁에 대해 존중 표현하기',
      '도와주지 못하는 합리적인 이유 제시',
      '집요한 요청에 대한 의사 표현하기',
    ],
    '진혁': [
      '거절 성공하기',
      '거절 의사 명확히 표현하기',
      '논리적 근거 제시하기',
      '일관성 있게 주장 유지하기',
      '상대방의 무례에 대한 불편함 명확히 표현하기',
    ],
  };

  // 캐릭터별 퀘스트 조건을 정의한 맵 (거절 카테고리와 매핑)
  final Map<String, List<List<String>>> questConditionMap = {
    '미연': [
      [], // 퀘스트 1: 거절 성공하기 (특정 거절 카테고리 없음)
      ['부탁 내용 확인'], // 퀘스트 2: 상대방이 처한 상황을 파악하기 위한 대화 시도하기
      ['아쉬움 표현', '도와주고 싶은 마음 표현', '상황에 대한 공감'], // 퀘스트 3: 감정에 대한 공감 표현
      ['이유 있는 거절'], // 퀘스트 4: 도와주지 못하는 이유 제시
      ['대안 제시'], // 퀘스트 5: 서로 양보해서 절충안 찾기
    ],
    '세진': [
      [], // 퀘스트 1: 거절 성공하기
      ['과거 배려에 대한 감사함 표시'], // 퀘스트 2: 감사 표현하기
      ['수락하지 못함에 대한 아쉬움 표현', "도와주고 싶은 마음 표현"], // 퀘스트 3: 감정적인 요소 포함하여 거절
      ['이유 있는 거절'], // 퀘스트 4: 이유 있는 거절 제시
      ['대안 제시'], // 퀘스트 5: 타협안 제시
    ],
    '현아': [
      [], // 퀘스트 1: 거절 성공하기
      ['시간 제한'], // 퀘스트 2: 시간 제한을 두고 거절
      ['상황에 대한 공감'], // 퀘스트 3: 존중 표현
      ['이유 있는 거절'], // 퀘스트 4: 이유 있는 거절 제시
      ['반복된 요청에 재차 단호한 거절'], // 퀘스트 5: 집요한 요청에 대한 의사 표현
    ],
    '진혁': [
      [], // 퀘스트 1: 거절 성공하기
      ['단호한 거절'], // 퀘스트 2: 타협하지 않기
      ['이유 있는 거절'], // 퀘스트 3: 논리적 근거 제시하기
      ['반복된 요청에 재차 단호한 거절'], // 퀘스트 4: 일관성 있게 주장 유지하기
      ['명확한 경계 설정'], // 퀘스트 5: 무례에 대한 불편함 명확히 표현하기
    ],
  };

  // 퀘스트 2, 3, 4, 5가 모두 달성되었는지 확인하는 메서드
  bool areMainQuestsAchieved() {
    // 퀘스트 2, 3, 4, 5가 모두 true인지 확인
    return questStatus[1] && questStatus[2] && questStatus[3] && questStatus[4];
  }

  // 미달성 퀘스트 리스트를 반환하는 메서드
  List<String> getUnachievedQuests() {
    List<String> unachievedQuests = [];
    for (int i = 1; i < questStatus.length; i++) {
      if (!questStatus[i]) {
        unachievedQuests
            .add(questContentMap[character.name]?[i] ?? '알 수 없는 퀘스트');
      }
    }
    return unachievedQuests;
  }

  // 캐릭터별 대화 횟수 요구 조건을 반환하는 메서드
  int _getRequiredChatLimitsForCharacter(String characterName) {
    switch (characterName) {
      case '미연':
        return 11; // 미연은 10회 대화 제한
      case '세진':
        return 11; // 세진은 8회 대화 제한
      case '현아':
        return 11; // 현아는 7회 대화 제한
      case '진혁':
        return 11; // 진혁은 6회 대화 제한
      default:
        return 0;
    }
  }

  // 미달성 퀘스트 리스트를 업데이트하는 메서드
  void updateUnachievedQuests() {
    unachievedQuests.clear(); // 기존 리스트 초기화
    for (int i = 1; i < questStatus.length; i++) {
      if (!questStatus[i]) {
        unachievedQuests.add(questContentMap[character.name]?[i] ?? '알 수 없는 퀘스트');
      }
    }
  }

  // 조건을 체크하고 토스트 메시지를 띄우는 메서드
  void checkQuestGuideConditions() {
    // Check for the specific rejection category '거절 승낙'
    if (aiResponse.rejectionContent.contains('거절 승낙')) {
      showToastMessage('거절을 승낙하지 말고 한 번 다시 거절해보세요!'); // Show the toast message
    }

    // Existing condition for chat count
    if (chatCount.value > 6) {
      showToastMessage('한 번 퀘스트를 따르며 거절을 해보세요! 😊');
    }
  }

  void showToastMessage(String message) {
    Get.snackbar(
      '대화 팁!', // Empty title
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.6), // Semi-transparent black background
      colorText: Colors.white, // White text
      margin: const EdgeInsets.all(16), // Margin around the toast
      borderRadius: 8.0, // Rounded corners
      duration: const Duration(seconds: 3), // Duration to show the message
    );
  }


}
