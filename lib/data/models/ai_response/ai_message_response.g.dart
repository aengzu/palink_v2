// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIMessageResponse _$AIMessageResponseFromJson(Map<String, dynamic> json) =>
    AIMessageResponse(
      message: json['message'] as String,
      isEnd: json['isEnd'] as bool,
    );

Map<String, dynamic> _$AIMessageResponseToJson(AIMessageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'isEnd': instance.isEnd,
    };
