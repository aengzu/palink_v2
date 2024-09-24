
import 'package:palink_v2/domain/model/character/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
  Future<Character> getCharacterById(int characterId);
}