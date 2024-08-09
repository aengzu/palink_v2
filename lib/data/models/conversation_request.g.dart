// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationRequest _$ConversationRequestFromJson(Map<String, dynamic> json) =>
    ConversationRequest(
      day: json['day'] as String,
      userId: json['user_id'] as String,
      characterId: (json['character_id'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationRequestToJson(
        ConversationRequest instance) =>
    <String, dynamic>{
      'day': instance.day,
      'user_id': instance.userId,
      'character_id': instance.characterId,
    };
