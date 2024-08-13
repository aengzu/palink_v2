// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackRequest _$FeedbackRequestFromJson(Map<String, dynamic> json) =>
    FeedbackRequest(
      conversationId: (json['conversationId'] as num).toInt(),
      feedbackText: json['feedbackText'] as String,
      finalLikingLevel: (json['finalLikingLevel'] as num).toInt(),
      totalRejectionScore: (json['totalRejectionScore'] as num).toInt(),
    );

Map<String, dynamic> _$FeedbackRequestToJson(FeedbackRequest instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'feedbackText': instance.feedbackText,
      'finalLikingLevel': instance.finalLikingLevel,
      'totalRejectionScore': instance.totalRejectionScore,
    };
