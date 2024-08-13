import 'package:json_annotation/json_annotation.dart';

part 'liking_response.g.dart';

@JsonSerializable()
class LikingResponse {
  final int messageId;
  final int likingLevel;
  final int conversationId;
  final int userId;
  final int likingId;

  LikingResponse({
    required this.messageId,
    required this.likingLevel,
    required this.conversationId,
    required this.userId,
    required this.likingId,
  });

  factory LikingResponse.fromJson(Map<String, dynamic> json) => _$LikingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LikingResponseToJson(this);
}
