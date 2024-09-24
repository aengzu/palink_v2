import 'package:palink_v2/domain/model/character/character_quest.dart';

abstract class CharacterQuestRepository {
  Future<List<CharacterQuest>> getAllCharacterQuests();
  Future<CharacterQuest?> getCharacterQuestsById(int characterId); // 새로운 메소드 추가
}
