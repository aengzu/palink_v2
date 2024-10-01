// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisRequest _$AnalysisRequestFromJson(Map<String, dynamic> json) =>
    AnalysisRequest(
      chatHistory: json['chatHistory'] as String,
      description: json['description'] as String,
      finalRejectionScore: (json['finalRejectionScore'] as num).toInt(),
    );

Map<String, dynamic> _$AnalysisRequestToJson(AnalysisRequest instance) =>
    <String, dynamic>{
      'chatHistory': instance.chatHistory,
      'description': instance.description,
      'finalRejectionScore': instance.finalRejectionScore,
    };
