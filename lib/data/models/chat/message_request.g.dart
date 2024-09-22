// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRequest _$MessageRequestFromJson(Map<String, dynamic> json) =>
    MessageRequest(
      sender: json['sender'] as bool,
      messageText: json['messageText'] as String,
      timestamp: json['timestamp'] as String,
      aiResponse:
          AIResponse.fromJson(json['aiResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageRequestToJson(MessageRequest instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'messageText': instance.messageText,
      'timestamp': instance.timestamp,
      'aiResponse': instance.aiResponse,
    };
