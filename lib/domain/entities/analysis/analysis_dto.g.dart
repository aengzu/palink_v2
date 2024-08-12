// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisDto _$AnalysisDtoFromJson(Map<String, dynamic> json) => AnalysisDto(
      evaluation: json['evaluation'] as String,
      usedRejection: json['used_rejection'] as String,
      finalRejectionScore: (json['final_rejection_score'] as num).toInt(),
    );

Map<String, dynamic> _$AnalysisDtoToJson(AnalysisDto instance) =>
    <String, dynamic>{
      'evaluation': instance.evaluation,
      'used_rejection': instance.usedRejection,
      'final_rejection_score': instance.finalRejectionScore,
    };
