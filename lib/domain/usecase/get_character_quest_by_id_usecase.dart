import 'package:palink_v2/domain/model/character/character_quest.dart';
import 'package:palink_v2/domain/repository/character_quest_repository.dart';

class GetCharacterQuestsByIdUsecase {
  final CharacterQuestRepository repository;

  GetCharacterQuestsByIdUsecase(this.repository);

  Future<CharacterQuest?> execute(int characterId) {
    return repository.getCharacterQuestsById(characterId);
  }
}
