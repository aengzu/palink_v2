// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRequest _$ChatRequestFromJson(Map<String, dynamic> json) => ChatRequest(
      persona: json['persona'] as String,
      userName: json['userName'] as String,
      userMessage: json['userMessage'] as String,
    );

Map<String, dynamic> _$ChatRequestToJson(ChatRequest instance) =>
    <String, dynamic>{
      'persona': instance.persona,
      'userName': instance.userName,
      'userMessage': instance.userMessage,
    };
