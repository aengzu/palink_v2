// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponseResponse _$AIResponseResponseFromJson(Map<String, dynamic> json) =>
    AIResponseResponse(
      feeling: json['feeling'] as String,
      text: json['text'] as String,
      rejectionScore: (json['rejectionScore'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      userMessage: json['userMessage'] as String,
      finalAffinityScore: (json['finalAffinityScore'] as num).toInt(),
      affinityScore: (json['affinityScore'] as num).toInt(),
      aiMessage: (json['aiMessage'] as num).toInt(),
      rejectionContent: (json['rejectionContent'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      finalRejectionScore: (json['finalRejectionScore'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
    );

Map<String, dynamic> _$AIResponseResponseToJson(AIResponseResponse instance) =>
    <String, dynamic>{
      'feeling': instance.feeling,
      'text': instance.text,
      'rejectionScore': instance.rejectionScore,
      'userMessage': instance.userMessage,
      'finalAffinityScore': instance.finalAffinityScore,
      'affinityScore': instance.affinityScore,
      'aiMessage': instance.aiMessage,
      'rejectionContent': instance.rejectionContent,
      'finalRejectionScore': instance.finalRejectionScore,
      'conversationId': instance.conversationId,
    };
