import 'package:json_annotation/json_annotation.dart';

part 'liking_request.g.dart';

@JsonSerializable()
class LikingRequest {
  final int messageId;
  final int likingLevel;
  final int conversationId;
  final int userId;

  LikingRequest({
    required this.messageId,
    required this.likingLevel,
    required this.conversationId,
    required this.userId,
  });

  factory LikingRequest.fromJson(Map<String, dynamic> json) => _$LikingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LikingRequestToJson(this);
}
