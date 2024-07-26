import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/domain/controllers/chatting_viewmodel.dart';
import 'package:palink_v2/domain/controllers/tip_viewmodel.dart';
import 'package:palink_v2/domain/controllers/user_controller.dart';
import 'package:palink_v2/utils/constants/app_fonts.dart';
import 'package:sizing/sizing.dart';
import 'components/messages.dart';
import 'components/profile_image.dart';
import 'components/tip_button.dart';



class ChatScreen extends StatelessWidget {
  final ChatViewModel viewModel;
  final UserController userController = Get.put(UserController());
  final TipButtonViewModel tipViewModel = Get.put(TipButtonViewModel());

  ChatScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.12,
          backgroundColor: Colors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProfileImage(
                    path: viewModel.character.image,
                    imageSize: 0.07.sh,
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 0.45.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(viewModel.character.name,
                            style: textTheme().bodyLarge?.copyWith(fontSize: 20)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        extendBodyBehindAppBar: false,
        body: Obx(() {
          return Container(
            color: viewModel.backgroundColor.value, // Update background color based on emotion
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        if (viewModel.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return viewModel.messages.isEmpty
                            ? const Center(
                          child: Text(
                            'No messages yet.',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                            : Messages(
                          messages: viewModel.messages,
                          userId: userController.userId.value,
                          characterImg: viewModel.character.image,
                          likingLevels: viewModel.likingLevels.value,
                        );
                      }),
                    ),
                    _sendMessageField(viewModel),
                  ],
                ),
                Positioned(
                  bottom: 110,
                  left: 20,
                  child: Obx(() {
                    return TipButton(
                      tipContent: viewModel.tipContent.value,
                      isExpanded: tipViewModel.isExpanded.value,
                      isLoading: tipViewModel.isLoading.value,
                      onToggle: tipViewModel.toggle,
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _sendMessageField(ChatViewModel viewModel) => SafeArea(
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
                    horizontal: 0.02.sw, vertical: 0.01.sh),
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
}