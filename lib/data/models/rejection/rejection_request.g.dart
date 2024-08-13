// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectionRequest _$RejectionRequestFromJson(Map<String, dynamic> json) =>
    RejectionRequest(
      messageId: (json['messageId'] as num).toInt(),
      rejectionLevel: (json['rejectionLevel'] as num).toInt(),
      characterId: (json['characterId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      rejectionText: json['rejectionText'] as String,
    );

Map<String, dynamic> _$RejectionRequestToJson(RejectionRequest instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'rejectionLevel': instance.rejectionLevel,
      'characterId': instance.characterId,
      'userId': instance.userId,
      'rejectionText': instance.rejectionText,
    };
