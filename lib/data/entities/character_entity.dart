// data/model/character_entity.dart
import 'package:floor/floor.dart';

@Entity(tableName: 'characters')
class CharacterEntity {
  @primaryKey
  final int characterId;
  final String name;
  final String type;
  final int requestStrength;
  final String prompt;
  final String description;
  final String image;
  final String quest;

  CharacterEntity({
    required this.characterId,
    required this.name,
    required this.type,
    required this.requestStrength,
    required this.prompt,
    required this.description,
    required this.image,
    required this.quest
  });
}
