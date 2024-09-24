// data/repositories/character_quest_repository_impl.dart

import 'package:palink_v2/data/dao/character_quest_dao.dart';
import 'package:palink_v2/domain/model/character/character_quest.dart';
import 'package:palink_v2/domain/repository/character_quest_repository.dart';

class CharacterQuestRepositoryImpl implements CharacterQuestRepository {
  final CharacterQuestDao characterQuestDao;

  CharacterQuestRepositoryImpl(this.characterQuestDao);

  @override
  Future<List<CharacterQuest>> getAllCharacterQuests() async {
    final entities = await characterQuestDao.getAllCharacterQuests();
    return entities
        .map((entity) => CharacterQuest(
              characterId: entity.characterId,
              quests: entity.quests.split(','),
            ))
        .toList();
  }

  @override
  Future<CharacterQuest?> getCharacterQuestsById(int characterId) async {
    final entity = await characterQuestDao.getCharacterQuestsById(characterId);
    if (entity != null) {
      return CharacterQuest(
        characterId: entity.characterId,
        quests: entity.quests.split(','),
      );
    }
    return null;
  }
}
