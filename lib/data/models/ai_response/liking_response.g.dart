// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikingResponse _$LikingResponseFromJson(Map<String, dynamic> json) =>
    LikingResponse(
      feeling: json['feeling'] as String,
      likability: (json['likability'] as num).toInt(),
    );

Map<String, dynamic> _$LikingResponseToJson(LikingResponse instance) =>
    <String, dynamic>{
      'feeling': instance.feeling,
      'likability': instance.likability,
    };
