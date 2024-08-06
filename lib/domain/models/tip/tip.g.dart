// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tip _$TipFromJson(Map<String, dynamic> json) => Tip(
      tipId: (json['tipId'] as num).toInt(),
      tipText: json['tipText'] as String,
      messageId: (json['messageId'] as num).toInt(),
    );

Map<String, dynamic> _$TipToJson(Tip instance) => <String, dynamic>{
      'tipId': instance.tipId,
      'tipText': instance.tipText,
      'messageId': instance.messageId,
    };
