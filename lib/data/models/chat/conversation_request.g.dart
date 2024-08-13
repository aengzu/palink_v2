// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationRequest _$ConversationRequestFromJson(Map<String, dynamic> json) =>
    ConversationRequest(
      day: json['day'] as String,
      userId: (json['userId'] as num).toInt(),
      characterId: (json['characterId'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationRequestToJson(
        ConversationRequest instance) =>
    <String, dynamic>{
      'day': instance.day,
      'userId': instance.userId,
      'characterId': instance.characterId,
    };
