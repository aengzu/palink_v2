// data/mappers/character_mapper.dart


import 'package:palink_v2/data/entities/character_entity.dart';
import 'package:palink_v2/domain/entities/character/character.dart';

class CharacterMapper {
  static Character fromEntity(CharacterEntity entity) {
    return Character(
      characterId: entity.characterId,
      name: entity.name,
      type: entity.type,
      requestStrength: entity.requestStrength,
      prompt: entity.prompt,
      description: entity.description,
      image: entity.image,
      anaylzePrompt: entity.analyzePrompt,
    );
  }
}
