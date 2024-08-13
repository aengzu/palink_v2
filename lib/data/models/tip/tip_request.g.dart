// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipRequest _$TipRequestFromJson(Map<String, dynamic> json) => TipRequest(
      messageId: (json['messageId'] as num).toInt(),
      tipText: json['tipText'] as String,
    );

Map<String, dynamic> _$TipRequestToJson(TipRequest instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'tipText': instance.tipText,
    };
