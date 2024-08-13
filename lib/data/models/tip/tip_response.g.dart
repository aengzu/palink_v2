// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipResponse _$TipResponseFromJson(Map<String, dynamic> json) => TipResponse(
      messageId: (json['messageId'] as num).toInt(),
      tipText: json['tipText'] as String,
      tipId: (json['tipId'] as num).toInt(),
    );

Map<String, dynamic> _$TipResponseToJson(TipResponse instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'tipText': instance.tipText,
      'tipId': instance.tipId,
    };
