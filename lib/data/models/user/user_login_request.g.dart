// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginRequest _$UserLoginRequestFromJson(Map<String, dynamic> json) =>
    UserLoginRequest(
      accountId: json['accountId'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginRequestToJson(UserLoginRequest instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'password': instance.password,
    };
