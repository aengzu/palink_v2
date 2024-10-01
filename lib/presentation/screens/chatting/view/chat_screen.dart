import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/data/models/mindset/mindset_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/chat_profile_section.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'package:sizing/sizing.dart';
import 'components/messages.dart';
import 'components/tip_button.dart';

class ChatScreen extends StatelessWidget {
  final ChatViewModel viewModel;
  final TipViewModel tipViewModel = Get.put(getIt<TipViewModel>());
  final String initialTip; // 첫번째 AI 메시지에 대한 팁
  final bool initialIsEnd;

  ChatScreen({
    super.key,
    required this.viewModel,
    required this.initialTip,
    required this.initialIsEnd,
  });

  @override
  Widget build(BuildContext context) {
    // 퀘스트 팝업이 처음에만 나타나도록 처리
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.showQuestPopupIfFirstTime(context);
    });

    if (initialIsEnd) {
      debugPrint('initialIsEnd is true');
      viewModel.navigateToChatEndScreen("거절을 승낙하여 대화가 종료되었어요" as MindsetResponse);
    }

    // 초기 팁 업데이트
    tipViewModel.updateTip(initialTip);

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
            imagePath: viewModel.character.image,
            characterName: viewModel.character.name,
            questStatus: viewModel.questStatus,
            onProfileTapped: () =>
                viewModel.showQuestPopup(context), // 프로필 클릭 시 퀘스트 팝업 표시,
            unachievedQuests: viewModel.unachievedQuests,
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
                  child: Obx(() {
                    return viewModel.messages.isEmpty
                        ? const Center(
                            child: Text(
                              '메시지가 없습니다.',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : Messages(
                            messages: viewModel.messages,
                            userId: viewModel.chatRoomId,
                            characterImg: viewModel.character.image,
                            onReactionAdded: (message, reaction) {
                              viewModel.addReactionToMessage(message, reaction);
                            },
                          );
                  }),
                ),
                _sendMessageField(viewModel),
              ],
            ),
            // 팁 버튼이 열렸을 때 배경을 어둡게 만드는 레이어 추가
            Obx(() {
              return tipViewModel.isExpanded.value
                  ? Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          tipViewModel.toggle(); // 배경을 탭하면 팁 버튼을 닫습니다.
                        },
                        child: Container(
                          color: Colors.black45, // 반투명 검정색 배경
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
            Positioned(
              bottom: 114,
              right: 20,
              child: Obx(() {
                return TipButton(
                  tipContent: tipViewModel.tipContent.value,
                  isExpanded: tipViewModel.isExpanded.value,
                  isLoading: tipViewModel.isLoading.value,
                  onToggle: tipViewModel.toggle,
                  backgroundColor: tipViewModel.tipContent.value.isEmpty
                      ? Colors.white70
                      : AppColors.deepBlue,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sendMessageField(ChatViewModel viewModel) => SafeArea(
    child: Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color.fromARGB(18, 0, 0, 0), blurRadius: 10),
        ],
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // Row의 요소를 아래쪽에 정렬
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              minLines: 1, // 최소 줄 수
              maxLines: 3, // 최대 줄 수
              keyboardType: TextInputType.multiline,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              controller: viewModel.textController,
              decoration: InputDecoration(
                hintText: "여기에 메시지를 입력하세요",
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
          const SizedBox(width: 10), // 텍스트 필드와 버튼 사이의 간격 추가
          Align(
            alignment: Alignment.bottomCenter, // 전송 버튼을 아래쪽에 고정
            child: IconButton(
              onPressed: () {
                if (viewModel.textController.text.isNotEmpty) {
                  viewModel.sendMessage();
                  viewModel.textController.clear();
                }
              },
              icon: const Icon(Icons.send),
              color: Colors.blue,
              iconSize: 25,
            ),
          ),
        ],
      ),
    ),
  );

  bool _isDialogOpen = false;


  void showQuestPopup(BuildContext context) async {
    if (!_isDialogOpen) {
      _isDialogOpen = true;
      final questInfo = await viewModel.getQuestInformation();
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
                  '${viewModel.character.name}과 대화 진행 시 퀘스트',
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
      ).then((_) {
        _isDialogOpen = false;
      });
    }
  }

}
