// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
      text: json['text'] as String,
      feeling: json['feeling'] as String,
      achievedQuest: json['achieved_quest'] as String,
      finalRejectionScore: (json['final_rejection_score'] as num).toInt(),
      rejectionScore: (json['rejection_score'] as num).toInt(),
      rejectionContents: json['rejection_contents'] as String,
      affinityScore: (json['affinity_score'] as num).toInt(),
      isEnd: (json['is_end'] as num).toInt(),
    );

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'feeling': instance.feeling,
      'achieved_quest': instance.achievedQuest,
      'final_rejection_score': instance.finalRejectionScore,
      'rejection_score': instance.rejectionScore,
      'rejection_contents': instance.rejectionContents,
      'affinity_score': instance.affinityScore,
      'is_end': instance.isEnd,
    };
