// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIMessageRequest _$AIMessageRequestFromJson(Map<String, dynamic> json) =>
    AIMessageRequest(
      persona: json['persona'] as String,
      userName: json['userName'] as String,
      userMessage: json['userMessage'] as String,
      chatHistory: json['chatHistory'] as String,
    );

Map<String, dynamic> _$AIMessageRequestToJson(AIMessageRequest instance) =>
    <String, dynamic>{
      'persona': instance.persona,
      'userName': instance.userName,
      'userMessage': instance.userMessage,
      'chatHistory': instance.chatHistory,
    };
