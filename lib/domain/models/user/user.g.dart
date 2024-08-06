// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      personalityType: json['personality_type'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'user_id': instance.userId,
      'age': instance.age,
      'personality_type': instance.personalityType,
    };
