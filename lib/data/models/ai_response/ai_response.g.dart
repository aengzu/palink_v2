// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
      text: json['text'] as String,
      feeling: json['feeling'] as String,
      isEnd: (json['is_end'] as num).toInt(),
      affinityScore: (json['affinity_score'] as num).toInt(),
      achievedQuest: json['achieved_quest'] as String,
      rejectionScore: (json['rejection_score'] as num).toInt(),
    );

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'is_end': instance.isEnd,
      'feeling': instance.feeling,
      'affinity_score': instance.affinityScore,
      'achieved_quest': instance.achievedQuest,
      'rejection_score': instance.rejectionScore,
    };