
import 'package:palink_v2/domain/entities/character/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
  Future<Character> getCharacterById(int characterId);
}