// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liking_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikingLevel _$LikingLevelFromJson(Map<String, dynamic> json) => LikingLevel(
      likingLevel: (json['likingLevel'] as num).toInt(),
      messageId: (json['messageId'] as num).toInt(),
    );

Map<String, dynamic> _$LikingLevelToJson(LikingLevel instance) =>
    <String, dynamic>{
      'likingLevel': instance.likingLevel,
      'messageId': instance.messageId,
    };
