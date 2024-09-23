
import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@JsonSerializable()
class Character {
  final int characterId;
  final String name;
  final String type;
  final int requestStrength;
  final String persona;
  final String? description;
  final String image;
  final String quest;

  Character({
    required this.characterId,
    required this.name,
    required this.type,
    required this.requestStrength,
    required this.persona,
    this.description,
    required this.image,
    required this.quest,
  });


  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

}
