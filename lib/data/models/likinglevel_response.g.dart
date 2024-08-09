// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likinglevel_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikinglevelResponse _$LikinglevelResponseFromJson(Map<String, dynamic> json) =>
    LikinglevelResponse(
      messageId: (json['message_id'] as num).toInt(),
      sender: json['sender'] as bool,
      messageText: json['message_text'] as String,
      timestamp: json['timestamp'] as String,
      conversationId: (json['conversation_id'] as num).toInt(),
    );

Map<String, dynamic> _$LikinglevelResponseToJson(
        LikinglevelResponse instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'sender': instance.sender,
      'message_text': instance.messageText,
      'timestamp': instance.timestamp,
      'conversation_id': instance.conversationId,
    };
