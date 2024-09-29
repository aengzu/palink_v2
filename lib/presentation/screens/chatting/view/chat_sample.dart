import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/chat_profile_section.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'package:sizing/sizing.dart';
import 'components/messages.dart';
import 'components/tip_button.dart';

class ChatSample extends StatelessWidget {

  ChatSample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white, // 기본 배경색 = 하얀색
        appBar: AppBar(
          toolbarHeight: 0.1.sh,
          backgroundColor: Colors.grey[100],
          title: ProfileSection(
            imagePath: '',
            characterName: '미연',
            questStatus: [false, true, false, false, false].obs,
            onProfileTapped: () =>
                showQuestPopup(context), // 프로필 클릭 시 퀘스트 팝업 표시,
            unachievedQuests: ['상대방이 처한 상황을 파악하기 위한 대화 시도', '이것은 미달성된 퀘스트이에요 가나다라마바사아자차가', '퀘스트3'].obs,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        extendBodyBehindAppBar: false,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Messages(
                      messages: dummyMessages.reversed.toList(),
                      userId: 1,
                      characterImg: 'assets/images/char1.png',
                      onReactionAdded: (message, reaction) {
                      },
                    )
                ),
                _sendMessageField(),
              ],
            ),
            // 팁 버튼이 열렸을 때 배경을 어둡게 만드는 레이어 추가
            Positioned(
              bottom: 110,
              right: 20,
              child: TipButton(
                  tipContent: '팁 내용이 담김',
                  isExpanded: false,
                  isLoading: false,
                  onToggle: () {
                  },
                  backgroundColor: AppColors.deepBlue
                )),
          ],
        ),
      ),
    );
  }

  Widget _sendMessageField() => SafeArea(
    child: Container(
      height: 0.07.sh,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color.fromARGB(18, 0, 0, 0), blurRadius: 10)
        ],
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                  iconSize: 25,
                ),
                hintText: "여기에 메시지를 입력하세요",
                hintMaxLines: 1,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 0.05.sw, vertical: 0.01.sh),
                hintStyle: const TextStyle(
                  fontSize: 16,
                ),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 0.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.black26,
                    width: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );


  void showQuestPopup(BuildContext context) async {
    final questInfo = '상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기\n상대방이 처한 상황을 파악하기 위한 대화 시도하기';
    // questInfo를 '\n'을 기준으로 분리하여 리스트로 변환
    List<String> questItems = questInfo.split('\n');

    await Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '미연과 대화 진행 시 퀘스트',
                style: textTheme().titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                '퀘스트는 프로필 상단 우측에 표시됩니다.\n퀘스트를 달성하면 퀘스트 아이콘 옆에 체크 표시가 나타납니다.\n 퀘스트를 확인하고 싶다면 프로필을 클릭하세요',
                style: textTheme().bodySmall,
              ),
              const SizedBox(height: 10),
              // questItems 리스트를 순회하며 각각 Text 위젯을 추가하고 사이에 SizedBox로 간격 추가
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: questInfo.split('\n').map((quest) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0), // 각 항목 사이에 간격 추가
                    child: Text(
                      quest,
                      style: textTheme().bodyMedium,
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

}
final List<Message> dummyMessages = [
  Message(
    id: '1',
    sender: true, // The message is from the user
    messageText: '안녕하세요! 오늘 기분이 어때요?',
    timestamp: '2024-09-26T10:30:24',
    affinityScore: 80,
    feeling: '중립 20, 분노 80',
    rejectionScore: [1, 0],
    reactions: [],
  ),
  Message(
    id: '2',
    sender: true, // The message is from the user
    messageText: '저도 좋아요! 오늘 무엇을 할 계획인가요?',
    timestamp: '2024-09-26T10:35:55',
    affinityScore: 90,
    feeling: '중립 20, 분노 80',
    rejectionScore: [0, 2],
    reactions: [],
  ),
  Message(
    id: '3',
    sender: false, // The message is from the character
    messageText: '아직 잘 모르겠어요. 같이 이야기하면서 정해볼까요?',
    timestamp: '2024-09-26T10:36:44',
    affinityScore: 75,
    feeling: '기쁨 10, 슬픔 10, 중립 20, 분노 60',
    rejectionScore: [1],
    reactions: [],
  ),
  Message(
    id: '4',
    sender: true, // The message is from the user
    messageText: '좋아요! 함께 무언가 재미있는 것을 찾아봅시다!',
    timestamp: '2024-09-26T10:40:30',
    affinityScore: 95,
    feeling: '기쁨 10, 슬픔 10, 중립 20, 분노 60',
    rejectionScore: [0],
    reactions: [],
  ),
];
