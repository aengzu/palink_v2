// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmotionCreateRequest _$EmotionCreateRequestFromJson(
        Map<String, dynamic> json) =>
    EmotionCreateRequest(
      emotionType: json['emotionType'] as String,
      vibrationPattern: (json['vibrationPattern'] as num).toInt(),
      backgroundColor: json['backgroundColor'] as String,
      messageId: (json['messageId'] as num).toInt(),
    );

Map<String, dynamic> _$EmotionCreateRequestToJson(
        EmotionCreateRequest instance) =>
    <String, dynamic>{
      'emotionType': instance.emotionType,
      'vibrationPattern': instance.vibrationPattern,
      'backgroundColor': instance.backgroundColor,
      'messageId': instance.messageId,
    };
