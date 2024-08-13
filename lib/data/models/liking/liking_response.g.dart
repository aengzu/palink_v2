// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikingResponse _$LikingResponseFromJson(Map<String, dynamic> json) =>
    LikingResponse(
      messageId: (json['messageId'] as num).toInt(),
      likingLevel: (json['likingLevel'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      likingId: (json['likingId'] as num).toInt(),
    );

Map<String, dynamic> _$LikingResponseToJson(LikingResponse instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'likingLevel': instance.likingLevel,
      'conversationId': instance.conversationId,
      'userId': instance.userId,
      'likingId': instance.likingId,
    };
