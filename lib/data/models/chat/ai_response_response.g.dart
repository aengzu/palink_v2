// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponseResponse _$AIResponseResponseFromJson(Map<String, dynamic> json) =>
    AIResponseResponse(
      feeling: json['feeling'] as String,
      text: json['text'] as String,
      rejectionScore: (json['rejection_score'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      userMessage: json['userMessage'] as String,
      finalAffinityScore: (json['final_affinity_score'] as num).toInt(),
      affinityScore: (json['affinity_score'] as num).toInt(),
      aiMessage: (json['aiMessage'] as num).toInt(),
      rejectionContent: (json['rejection_content'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      finalRejectionScore: (json['final_rejection_score'] as num).toInt(),
      conversationId: (json['conversation_id'] as num).toInt(),
    );

Map<String, dynamic> _$AIResponseResponseToJson(AIResponseResponse instance) =>
    <String, dynamic>{
      'feeling': instance.feeling,
      'text': instance.text,
      'rejection_score': instance.rejectionScore,
      'userMessage': instance.userMessage,
      'final_affinity_score': instance.finalAffinityScore,
      'affinity_score': instance.affinityScore,
      'aiMessage': instance.aiMessage,
      'rejection_content': instance.rejectionContent,
      'final_rejection_score': instance.finalRejectionScore,
      'conversation_id': instance.conversationId,
    };
