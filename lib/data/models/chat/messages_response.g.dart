// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesResponse _$MessagesResponseFromJson(Map<String, dynamic> json) =>
    MessagesResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesResponseToJson(MessagesResponse instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
