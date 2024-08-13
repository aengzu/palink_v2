import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';


part 'conversations_response.g.dart';

@JsonSerializable()
class ConversationsResponse {
  final List<ConversationResponse> conversations;

  ConversationsResponse({required this.conversations});

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) => _$ConversationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationsResponseToJson(this);
}
