// data/dao/character_quest_dao.dart
import 'package:floor/floor.dart';
import 'package:palink_v2/data/entities/character_quest_entity.dart';

@dao
abstract class CharacterQuestDao {
  @Query('SELECT * FROM character_quests')
  Future<List<CharacterQuestEntity>> getAllCharacterQuests();

  @Query('SELECT * FROM character_quests WHERE characterId = :characterId')
  Future<CharacterQuestEntity?> getCharacterQuestsById(int characterId); // 새로운 메소드 추가
}
