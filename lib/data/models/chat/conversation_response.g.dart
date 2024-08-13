// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationResponse _$ConversationResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationResponse(
      day: json['day'] as String,
      userId: (json['userId'] as num).toInt(),
      characterId: (json['characterId'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationResponseToJson(
        ConversationResponse instance) =>
    <String, dynamic>{
      'day': instance.day,
      'userId': instance.userId,
      'characterId': instance.characterId,
      'conversationId': instance.conversationId,
    };
