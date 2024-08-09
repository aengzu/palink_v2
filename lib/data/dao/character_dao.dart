import 'package:floor/floor.dart';
import 'package:palink_v2/data/entities/character_entity.dart';

@dao
abstract class CharacterDao {
  @Query('SELECT * FROM characters')
  Future<List<CharacterEntity>> getAllCharacters();

  @Query('SELECT * FROM characters WHERE characterId = :characterId')
  Future<CharacterEntity?> getCharacterById(int characterId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCharacter(CharacterEntity character);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCharacters(List<CharacterEntity> characters);
}
