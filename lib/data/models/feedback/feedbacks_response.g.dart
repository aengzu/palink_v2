// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedbacks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbacksResponse _$FeedbacksResponseFromJson(Map<String, dynamic> json) =>
    FeedbacksResponse(
      feedbacks: (json['feedbacks'] as List<dynamic>)
          .map((e) => FeedbackResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbacksResponseToJson(FeedbacksResponse instance) =>
    <String, dynamic>{
      'feedbacks': instance.feedbacks,
    };
