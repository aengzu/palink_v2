// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      characterId: (json['characterId'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      requestStrength: (json['requestStrength'] as num).toInt(),
      persona: json['persona'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
      quest: json['quest'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'characterId': instance.characterId,
      'name': instance.name,
      'type': instance.type,
      'requestStrength': instance.requestStrength,
      'persona': instance.persona,
      'description': instance.description,
      'image': instance.image,
      'quest': instance.quest,
    };
