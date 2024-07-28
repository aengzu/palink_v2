// presentation/screens/character_select/character_select_viewmodel.dart
import 'package:get/get.dart';
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/domain/usecase/get_character_usecase.dart';


class CharacterSelectViewModel extends GetxController {
  final GetCharactersUseCase getCharactersUseCase;
  var characters = <Character>[].obs;

  CharacterSelectViewModel({required this.getCharactersUseCase});

  @override
  void onInit() {
    print('CharacterSelectViewModel onInit');
    super.onInit();
    loadCharacters();
  }

  void loadCharacters() async {
    final result = await getCharactersUseCase.call();
    characters.assignAll(result);
  }
}
