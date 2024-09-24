import 'package:get/get.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/chat/conversation.dart';
import 'package:palink_v2/domain/usecase/get_chatroom_by_user.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';

class MyfeedbacksViewmodel extends GetxController {
  final GetChatroomByUser getChatroomByUser = Get.put(getIt<GetChatroomByUser>());
  final CharacterRepository characterRepository = Get.put(getIt<CharacterRepository>());

  List<Conversation> chatrooms = [];
  Map<int, Character> characters = {}; // 캐릭터 정보 저장

  MyfeedbacksViewmodel();

  @override
  void onInit() {
    super.onInit();
    _loadChatRooms();
  }

  void _loadChatRooms() async {
    try {
      var fetchedData = await getChatroomByUser.execute();
      chatrooms = fetchedData;

      // 캐릭터 ID에 해당하는 캐릭터 데이터 불러오기
      for (var conversation in chatrooms) {
        var characterId = conversation.characterId;

        var character = await characterRepository.getCharacterById(characterId);
        characters[characterId] = character; // 캐릭터 정보 저장
      }

      update(); // UI 업데이트
    } catch (e) {
      // 에러 발생 시 처리
      Get.snackbar('Error', 'Failed to load chatrooms');
    }
  }
}
