// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      messageId: (json['message_id'] as num).toInt(),
      sender: json['sender'] as bool,
      messageText: json['message_text'] as String,
      timestamp: json['timestamp'] as String,
      conversationId: (json['conversation_id'] as num).toInt(),
    );

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'sender': instance.sender,
      'message_text': instance.messageText,
      'timestamp': instance.timestamp,
      'conversation_id': instance.conversationId,
    };
