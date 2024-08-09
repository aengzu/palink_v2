// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likinglevel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikinglevelRequest _$LikinglevelRequestFromJson(Map<String, dynamic> json) =>
    LikinglevelRequest(
      userId: json['user_id'] as String,
      characterId: (json['character_id'] as num).toInt(),
      likingLevel: (json['likingLevel'] as num).toInt(),
      messageId: (json['message_id'] as num).toInt(),
    );

Map<String, dynamic> _$LikinglevelRequestToJson(LikinglevelRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'character_id': instance.characterId,
      'likingLevel': instance.likingLevel,
      'message_id': instance.messageId,
    };
