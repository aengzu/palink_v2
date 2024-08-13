// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikingRequest _$LikingRequestFromJson(Map<String, dynamic> json) =>
    LikingRequest(
      messageId: (json['messageId'] as num).toInt(),
      likingLevel: (json['likingLevel'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$LikingRequestToJson(LikingRequest instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'likingLevel': instance.likingLevel,
      'conversationId': instance.conversationId,
      'userId': instance.userId,
    };
