// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      text: json['text'] as String,
      isEnd: json['isEnd'] as bool,
      affinityScore: (json['affinityScore'] as num).toInt(),
      feeling: json['feeling'] as String,
    );

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isEnd': instance.isEnd,
      'affinityScore': instance.affinityScore,
      'feeling': instance.feeling,
    };
