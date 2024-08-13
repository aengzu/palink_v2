// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCollectionResponse _$UserCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    UserCollectionResponse(
      characterId: (json['characterId'] as num).toInt(),
      addedDate: json['addedDate'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$UserCollectionResponseToJson(
        UserCollectionResponse instance) =>
    <String, dynamic>{
      'characterId': instance.characterId,
      'addedDate': instance.addedDate,
      'userId': instance.userId,
    };
