// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisDto _$AnalysisDtoFromJson(Map<String, dynamic> json) => AnalysisDto(
      evaluation: json['evaluation'] as String,
      finalRejectionScore: (json['final_rejection_score'] as num).toInt(),
      finalAffinityScore: (json['final_affinity_score'] as num).toInt(),
      unachievedQuests: json['unachievedQuests'] as String,
      usedRejection: json['usedRejection'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AnalysisDtoToJson(AnalysisDto instance) =>
    <String, dynamic>{
      'evaluation': instance.evaluation,
      'final_rejection_score': instance.finalRejectionScore,
      'final_affinity_score': instance.finalAffinityScore,
      'unachievedQuests': instance.unachievedQuests,
      'usedRejection': instance.usedRejection,
      'type': instance.type,
    };
