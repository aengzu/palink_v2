// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
      userId: json['user_id'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      personalityType: json['personality_type'] as String,
    );

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'password': instance.password,
      'name': instance.name,
      'age': instance.age,
      'personality_type': instance.personalityType,
    };
