// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipRequest _$TipRequestFromJson(Map<String, dynamic> json) => TipRequest(
      message: json['message'] as String,
      unachievedQuests: (json['unachievedQuests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TipRequestToJson(TipRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'unachievedQuests': instance.unachievedQuests,
    };
