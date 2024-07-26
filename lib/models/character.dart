import 'package:palink_v2/constants/app_images.dart';
import 'package:palink_v2/constants/prompts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@JsonSerializable()
class Character {
  final int characterId;
  final String name;
  final String type;
  final int requestStrength;
  final String prompt;
  final String? description;
  final String image;
  final String anaylzePrompt;

  Character({
    required this.characterId,
    required this.name,
    required this.type,
    required this.requestStrength,
    required this.prompt,
    this.description,
    required this.image,
    required this.anaylzePrompt,
  });


  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

}
