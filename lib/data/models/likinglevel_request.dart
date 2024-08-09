import 'package:json_annotation/json_annotation.dart';

part 'likinglevel_request.g.dart';

@JsonSerializable()
class LikinglevelRequest {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'character_id')
  final int characterId;
  final int likingLevel;
  @JsonKey(name: 'message_id')
  final int messageId;

  LikinglevelRequest({
    required this.userId,
    required this.characterId,
    required this.likingLevel,
    required this.messageId,
  });

  factory LikinglevelRequest.fromJson(Map<String, dynamic> json) =>
      _$LikinglevelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LikinglevelRequestToJson(this);
}
