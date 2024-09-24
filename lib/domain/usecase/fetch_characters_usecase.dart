import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';

class FetchCharactersUsecase {
  final CharacterRepository repository;

  FetchCharactersUsecase(this.repository);

  Future<List<Character>> execute() {
    return repository.getCharacters();
  }
}
