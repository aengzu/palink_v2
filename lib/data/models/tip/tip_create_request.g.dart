// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipCreateRequest _$TipCreateRequestFromJson(Map<String, dynamic> json) =>
    TipCreateRequest(
      messageId: (json['messageId'] as num).toInt(),
      tipText: json['tipText'] as String,
    );

Map<String, dynamic> _$TipCreateRequestToJson(TipCreateRequest instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'tipText': instance.tipText,
    };
