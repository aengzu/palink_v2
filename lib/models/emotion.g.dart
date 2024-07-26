// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emotion _$EmotionFromJson(Map<String, dynamic> json) => Emotion(
      emotionType: json['emotionType'] as String,
      vibrationPattern: json['vibrationPattern'] as String,
      backgroundColor: json['backgroundColor'] as String,
    );

Map<String, dynamic> _$EmotionToJson(Emotion instance) => <String, dynamic>{
      'emotionType': instance.emotionType,
      'vibrationPattern': instance.vibrationPattern,
      'backgroundColor': instance.backgroundColor,
    };
