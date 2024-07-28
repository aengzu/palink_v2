// domain/repository/character_repository.dart
import 'package:palink_v2/domain/models/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
}