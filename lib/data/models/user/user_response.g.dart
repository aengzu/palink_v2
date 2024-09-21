// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      accountId: json['accountId'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'name': instance.name,
      'age': instance.age,
      'userId': instance.userId,
    };
