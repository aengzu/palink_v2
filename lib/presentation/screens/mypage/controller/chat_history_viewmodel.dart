import 'package:get/get.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:palink_v2/domain/usecase/fetch_chat_history_usecase.dart';

class ChatHistoryViewmodel extends GetxController {
  final FetchChatHistoryUsecase getChatHistoryUsecase = Get.put(getIt<FetchChatHistoryUsecase>());

  List<Message>? messages; // 단일 피드백 정보 저장
  Character? character; // 캐릭터 정보 저장
  int chatroomId; // 채팅방 ID
  RxBool conversationNotFound = true.obs; // 404 처리 플래그


  ChatHistoryViewmodel({
    required this.chatroomId,
  });

  @override
  void onInit() {
    super.onInit();
    conversationNotFound.value = true;
    loadMessages();
  }

  // 메시지 로드
  void loadMessages() async {
    try {
      // 메시지 가져오기
      messages = await getChatHistoryUsecase.execute(chatroomId);
      messages = messages!.reversed.toList();
      conversationNotFound.value = false; // 404 에러가 발생하지 않은 경우 플래그 설정;
      update();
    } catch (e) {
      // 404 에러 발생 시 처리
      if (e.toString().contains('404')) {
        conversationNotFound.value = true;  // 404 에러가 발생한 경우 플래그 설정
      } else {
        Get.snackbar('Error', 'Failed to load feedback');
      }
      update();
    }
  }
}
