// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisResponse _$AnalysisResponseFromJson(Map<String, dynamic> json) =>
    AnalysisResponse(
      evaluation: json['evaluation'] as String,
      usedRejection: json['usedRejection'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AnalysisResponseToJson(AnalysisResponse instance) =>
    <String, dynamic>{
      'evaluation': instance.evaluation,
      'usedRejection': instance.usedRejection,
      'type': instance.type,
    };
