import 'package:palink_v2/data/dao/character_dao.dart';
import 'package:palink_v2/data/mapper/character_mapper.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDao characterDao = getIt<CharacterDao>();

  CharacterRepositoryImpl();

  @override
  Future<List<Character>> getCharacters() async {
    final entities = await characterDao.getAllCharacters();
    return entities.map((e) => CharacterMapper.fromEntity(e)).toList();
  }

  @override
  Future<Character> getCharacterById(int characterId) async {
    final entity = await characterDao.getCharacterById(characterId);
    if (entity == null) {
      throw Exception('Character not found');
    }
    return CharacterMapper.fromEntity(entity);
  }
}
