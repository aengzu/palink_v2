// domain/usecase/get_characters_usecase.dart
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';

class GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCase(this.repository);

  Future<List<Character>> call() {
    return repository.getCharacters();
  }
}
