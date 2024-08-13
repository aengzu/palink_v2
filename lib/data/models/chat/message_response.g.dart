// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      sender: json['sender'] as bool,
      messageText: json['messageText'] as String,
      timestamp: json['timestamp'] as String,
      messageId: (json['messageId'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
    );

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'messageText': instance.messageText,
      'timestamp': instance.timestamp,
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
    };
