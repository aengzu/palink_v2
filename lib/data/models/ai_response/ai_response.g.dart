// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
      text: json['text'] as String,
      feeling: json['feeling'] as String,
      affinityScore: (json['affinity_score'] as num).toInt(),
      rejectionScore: (json['rejection_score'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      rejectionContent: (json['rejection_content'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      finalRejectionScore: (json['final_rejection_score'] as num).toInt(),
      finalAffinityScore: (json['final_affinity_score'] as num).toInt(),
    );

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'feeling': instance.feeling,
      'affinity_score': instance.affinityScore,
      'rejection_score': instance.rejectionScore,
      'rejection_content': instance.rejectionContent,
      'final_rejection_score': instance.finalRejectionScore,
      'final_affinity_score': instance.finalAffinityScore,
    };
