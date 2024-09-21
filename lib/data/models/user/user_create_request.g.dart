// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateRequest _$UserCreateRequestFromJson(Map<String, dynamic> json) =>
    UserCreateRequest(
      accountId: json['accountId'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserCreateRequestToJson(UserCreateRequest instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'name': instance.name,
      'age': instance.age,
      'password': instance.password,
    };
