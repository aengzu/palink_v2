import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/data/models/character/character_response.dart';


part 'characters_response.g.dart';

@JsonSerializable()
class CharactersResponse {
  final List<CharacterResponse> characters;

  CharactersResponse({required this.characters});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) => _$CharactersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}
