import 'package:json_annotation/json_annotation.dart';
import 'message_response.dart';

part 'messages_response.g.dart';

@JsonSerializable()
class MessagesResponse {
  final List<MessageResponse> messages;

  MessagesResponse({required this.messages});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) => _$MessagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesResponseToJson(this);
}
