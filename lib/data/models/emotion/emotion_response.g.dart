// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmotionResponse _$EmotionResponseFromJson(Map<String, dynamic> json) =>
    EmotionResponse(
      emotionType: json['emotionType'] as String,
      vibrationPattern: (json['vibrationPattern'] as num).toInt(),
      backgroundColor: json['backgroundColor'] as String,
      messageId: (json['messageId'] as num).toInt(),
      emotionId: (json['emotionId'] as num).toInt(),
    );

Map<String, dynamic> _$EmotionResponseToJson(EmotionResponse instance) =>
    <String, dynamic>{
      'emotionType': instance.emotionType,
      'vibrationPattern': instance.vibrationPattern,
      'backgroundColor': instance.backgroundColor,
      'messageId': instance.messageId,
      'emotionId': instance.emotionId,
    };
