// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRequest _$MessageRequestFromJson(Map<String, dynamic> json) =>
    MessageRequest(
      sender: json['sender'] as bool,
      messageText: json['message_text'] as String,
      timestamp: json['timestamp'] as String,
      conversationId: (json['conversation_id'] as num).toInt(),
    );

Map<String, dynamic> _$MessageRequestToJson(MessageRequest instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'message_text': instance.messageText,
      'timestamp': instance.timestamp,
      'conversation_id': instance.conversationId,
    };
