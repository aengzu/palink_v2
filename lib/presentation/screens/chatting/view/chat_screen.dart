import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/chat_profile_section.dart';
import 'package:palink_v2/presentation/screens/common/custom_btn.dart';
import 'package:palink_v2/presentation/screens/common/custom_button_md.dart';
import 'package:sizing/sizing.dart';
import 'components/messages.dart';
import 'components/profile_image.dart';
import 'components/tip_button.dart';

class ChatScreen extends StatelessWidget {
  final ChatViewModel viewModel;
  final TipViewModel tipViewModel = Get.put(getIt<TipViewModel>());
  final String initialTip; // 첫번째 AI 메시지에 대한 팁

  ChatScreen({
    super.key, required this.viewModel, required this.initialTip,
  });

  @override
  Widget build(BuildContext context) {
    // 초기 팁 업데이트
    tipViewModel.updateTip(initialTip);
    // 퀘스트 정보 팝업을 처음 빌드할 때 표시
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showQuestPopup(context);
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.1.sh,
            backgroundColor: Colors.white,
            title: ProfileSection(
              imagePath: viewModel.character.image,
              characterName: viewModel.character.name,
              questStatus: viewModel.questStatus, // 퀘스트 달성 여부 전달
              onProfileTapped: () => _showQuestPopup(context), // 다이얼로그 트리거 콜백 전달
            ),
            centerTitle: true,
            elevation: 0,
          ),
          extendBodyBehindAppBar: false,
          body: Container(
            color: Colors.white,
            child: Stack(
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
                          likingLevels: viewModel.likingLevels,
                        );
                      }),
                    ),
                    _sendMessageField(viewModel),
                  ],
                ),
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: Obx(() {
                    return TipButton(
                      tipContent: tipViewModel.tipContent.value,
                      isExpanded: tipViewModel.isExpanded.value,
                      isLoading: tipViewModel.isLoading.value,
                      onToggle: tipViewModel.toggle,
                      backgroundColor: tipViewModel.tipContent.value.isEmpty
                          ? Colors.white70
                          : AppColors.deepBlue, // 원래의 배경색으로 대체하세요
                    );
                  }),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _sendMessageField(ChatViewModel viewModel) =>
      SafeArea(
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
                  controller: viewModel.textController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
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

  bool _isDialogOpen = false;

  void _showQuestPopup(BuildContext context) async {
    if (!_isDialogOpen) {
      _isDialogOpen = true;
      final questInfo = await viewModel.getQuestInformation();
      Get.dialog(
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
                  '${viewModel.character.name}과 대화 진행 시 퀘스트',
                  style: textTheme().titleMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  '퀘스트는 프로필 상단 우측에 표시됩니다.\n퀘스트를 달성하면 퀘스트 아이콘 옆에 체크 표시가 나타납니다.\n 퀘스트를 확인하고 싶다면 프로필을 클릭하세요',
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
                    Get.back();
                    _isDialogOpen = false; // 다이얼로그 닫힘 상태 업데이트
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