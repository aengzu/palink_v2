// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResponse _$CharacterResponseFromJson(Map<String, dynamic> json) =>
    CharacterResponse(
      aiName: json['aiName'] as String,
      description: json['description'] as String,
      difficultyLevel: (json['difficultyLevel'] as num).toInt(),
      characterId: (json['characterId'] as num).toInt(),
    );

Map<String, dynamic> _$CharacterResponseToJson(CharacterResponse instance) =>
    <String, dynamic>{
      'aiName': instance.aiName,
      'description': instance.description,
      'difficultyLevel': instance.difficultyLevel,
      'characterId': instance.characterId,
    };
