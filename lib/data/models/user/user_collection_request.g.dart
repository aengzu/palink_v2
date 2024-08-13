// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCollectionRequest _$UserCollectionRequestFromJson(
        Map<String, dynamic> json) =>
    UserCollectionRequest(
      characterId: (json['characterId'] as num).toInt(),
      addedDate: json['addedDate'] as String,
    );

Map<String, dynamic> _$UserCollectionRequestToJson(
        UserCollectionRequest instance) =>
    <String, dynamic>{
      'characterId': instance.characterId,
      'addedDate': instance.addedDate,
    };
