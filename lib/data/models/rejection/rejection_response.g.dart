// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectionResponse _$RejectionResponseFromJson(Map<String, dynamic> json) =>
    RejectionResponse(
      messageId: (json['messageId'] as num).toInt(),
      rejectionLevel: (json['rejectionLevel'] as num).toInt(),
      characterId: (json['characterId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      rejectionText: json['rejectionText'] as String,
      rejectionId: (json['rejectionId'] as num).toInt(),
    );

Map<String, dynamic> _$RejectionResponseToJson(RejectionResponse instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'rejectionLevel': instance.rejectionLevel,
      'characterId': instance.characterId,
      'userId': instance.userId,
      'rejectionText': instance.rejectionText,
      'rejectionId': instance.rejectionId,
    };
