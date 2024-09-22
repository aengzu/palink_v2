// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisRequest _$AnalysisRequestFromJson(Map<String, dynamic> json) =>
    AnalysisRequest(
      chatHistory: json['chatHistory'] as String,
      quest: json['quest'] as String,
      rejectionContent: json['rejectionContent'] as String,
    );

Map<String, dynamic> _$AnalysisRequestToJson(AnalysisRequest instance) =>
    <String, dynamic>{
      'chatHistory': instance.chatHistory,
      'quest': instance.quest,
      'rejectionContent': instance.rejectionContent,
    };
