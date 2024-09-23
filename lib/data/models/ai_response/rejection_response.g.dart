// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectionResponse _$RejectionResponseFromJson(Map<String, dynamic> json) =>
    RejectionResponse(
      rejectionContent: (json['rejectionContent'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RejectionResponseToJson(RejectionResponse instance) =>
    <String, dynamic>{
      'rejectionContent': instance.rejectionContent,
    };
