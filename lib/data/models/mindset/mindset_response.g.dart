// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mindset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MindsetResponse _$MindsetResponseFromJson(Map<String, dynamic> json) =>
    MindsetResponse(
      mindsetText: json['mindsetText'] as String,
      mindsetId: (json['mindsetId'] as num).toInt(),
    );

Map<String, dynamic> _$MindsetResponseToJson(MindsetResponse instance) =>
    <String, dynamic>{
      'mindsetText': instance.mindsetText,
      'mindsetId': instance.mindsetId,
    };
