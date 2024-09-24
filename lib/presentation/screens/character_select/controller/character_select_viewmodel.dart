// presentation/screens/character_select/character_select_viewmodel.dart
import 'package:get/get.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/usecase/fetch_characters_usecase.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_loading_viewmodel.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_loading_screen.dart';

class CharacterSelectViewModel extends GetxController {
  final FetchCharactersUsecase fetchCharactersUsecase;
  var characters = <Character>[].obs;
  var selectedCharacter = Character(
          characterId: 1,
          name: 'default_name',
          type: 'default_type',
          image: 'default_image.png',
          quest: 'default_quest',
          requestStrength: 0,
          persona: 'default_prompt')
      .obs;

  CharacterSelectViewModel({required this.fetchCharactersUsecase});

  @override
  void onInit() {
    super.onInit();
    _initSelectedCharacter();
    _loadCharacters();
  }

  void _loadCharacters() async {
    final result = await fetchCharactersUsecase.execute();
    characters.assignAll(result);
  }

  void selectCharacter(Character character) {
    selectedCharacter.value = character;
    Get.off(() => ChatLoadingScreen(
        viewModel: Get.put(ChatLoadingViewModel(character: character))));
  }

  void _initSelectedCharacter() {
    selectedCharacter.value = Character(
        characterId: 1,
        name: 'default_name',
        type: 'default_type',
        image: 'default_image.png',
        quest: 'default_quest',
        requestStrength: 0,
        persona: 'default_prompt');
  }
}
