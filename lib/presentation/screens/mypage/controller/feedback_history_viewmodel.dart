import 'package:get/get.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/analysis/feedback.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/usecase/get_feedback_by_conversation_usecase.dart';

class FeedbackHistoryViewModel extends GetxController {
  final GetFeedbackByConversationUsecase getFeedbackByConversationUsecase = Get.put(getIt<GetFeedbackByConversationUsecase>());

  Feedback? feedback; // 단일 피드백 정보 저장
  Character? character; // 캐릭터 정보 저장
  int chatroomId; // 채팅방 ID
  RxBool feedbackNotFound = true.obs; // 404 처리 플래그


  FeedbackHistoryViewModel({
    required this.chatroomId,
  });

  @override
  void onInit() {
    super.onInit();
    feedbackNotFound.value = true;
    loadFeedbackData();
  }

  // 피드백 데이터 및 캐릭터 데이터 로드
  void loadFeedbackData() async {
    try {
      // 피드백 가져오기
      feedback = await getFeedbackByConversationUsecase.execute(chatroomId);
      feedbackNotFound.value = false; // 404 에러가 발생하지 않은 경우 플래그 설정;
      update();
    } catch (e) {
      // 404 에러 발생 시 처리
      if (e.toString().contains('404')) {
        feedbackNotFound.value = true;  // 404 에러가 발생한 경우 플래그 설정
      } else {
        Get.snackbar('Error', 'Failed to load feedback');
      }
      update();
    }
  }
}
