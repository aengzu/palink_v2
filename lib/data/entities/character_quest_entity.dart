// data/model/character_quest_entity.dart
import 'package:floor/floor.dart';

@Entity(tableName: 'character_quests')
class CharacterQuestEntity {
  @primaryKey
  final int characterId;
  final String quests;

  CharacterQuestEntity({
    required this.characterId,
    required this.quests,
  });
}
