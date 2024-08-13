import 'package:json_annotation/json_annotation.dart';

part 'character_response.g.dart';

@JsonSerializable()
class CharacterResponse {
  final String aiName;
  final String description;
  final int difficultyLevel;
  final int characterId;

  CharacterResponse({
    required this.aiName,
    required this.description,
    required this.difficultyLevel,
    required this.characterId,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) => _$CharacterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterResponseToJson(this);
}
