// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipResponse _$TipResponseFromJson(Map<String, dynamic> json) => TipResponse(
      answer: json['answer'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$TipResponseToJson(TipResponse instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'reason': instance.reason,
    };
