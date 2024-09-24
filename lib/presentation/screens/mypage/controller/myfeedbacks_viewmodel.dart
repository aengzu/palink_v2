import 'package:get/get.dart';
import 'package:palink_v2/domain/usecase/get_chatroom_by_user.dart';

class MyfeedbacksViewmodel extends GetxController {
  final GetChatroomByUser getChatroomByUser;

  MyfeedbacksViewmodel(this.getChatroomByUser);

  @override
  void onInit() {
    super.onInit();
    _loadChatRooms();
  }

  void _loadChatRooms() async {
    try {
      final chatroom = await getChatroomByUser.execute();
      if (chatroom != null) {
      } else {
        Get.snackbar('Error', 'Failed to load user data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while loading user data');
    }
  }
}
