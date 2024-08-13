// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationsResponse _$ConversationsResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationsResponse(
      conversations: (json['conversations'] as List<dynamic>)
          .map((e) => ConversationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConversationsResponseToJson(
        ConversationsResponse instance) =>
    <String, dynamic>{
      'conversations': instance.conversations,
    };
