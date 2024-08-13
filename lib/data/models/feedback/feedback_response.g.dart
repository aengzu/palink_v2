// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackResponse _$FeedbackResponseFromJson(Map<String, dynamic> json) =>
    FeedbackResponse(
      conversationId: (json['conversationId'] as num).toInt(),
      feedbackText: json['feedbackText'] as String,
      finalLikingLevel: (json['finalLikingLevel'] as num).toInt(),
      totalRejectionScore: (json['totalRejectionScore'] as num).toInt(),
      feedbackId: (json['feedbackId'] as num).toInt(),
    );

Map<String, dynamic> _$FeedbackResponseToJson(FeedbackResponse instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'feedbackText': instance.feedbackText,
      'finalLikingLevel': instance.finalLikingLevel,
      'totalRejectionScore': instance.totalRejectionScore,
      'feedbackId': instance.feedbackId,
    };
