// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationResponse _$ConversationResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationResponse(
      conversationId: (json['conversation_id'] as num).toInt(),
      day: json['day'] as String,
      userId: json['user_id'] as String,
      characterId: (json['character_id'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationResponseToJson(
        ConversationResponse instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversationId,
      'day': instance.day,
      'user_id': instance.userId,
      'character_id': instance.characterId,
    };
