// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRequest _$MessageRequestFromJson(Map<String, dynamic> json) =>
    MessageRequest(
      sender: json['sender'] as bool,
      messageText: json['messageText'] as String,
      timestamp: json['timestamp'] as String,
      aiResponse: json['ai_response'] == null
          ? null
          : AIResponse.fromJson(json['ai_response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageRequestToJson(MessageRequest instance) {
  final val = <String, dynamic>{
    'sender': instance.sender,
    'messageText': instance.messageText,
    'timestamp': instance.timestamp,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ai_response', instance.aiResponse);
  return val;
}
