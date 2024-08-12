import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Likability {
  final int likingId;
  final String userId;
  final int characterId;
  final int likingLevel;
  final int messageId;

  Likability(
      {required this.likingId,
      required this.userId,
      required this.characterId,
      required this.likingLevel,
      required this.messageId});

  factory Likability.fromJson(Map<String, dynamic> json) {
    return Likability(
        likingId: json['liking_id'],
        userId: json['user_id'],
        characterId: json['character_id'],
        likingLevel: json['liking_level'],
        messageId: json['message_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'liking_id': likingId,
      'user_id': userId,
      'character_id': characterId,
      'liking_level': likingLevel,
      'message_id': messageId
    };
  }
}

class LikabilityDto {
  final String userId;
  final int characterId;
  final int likingLevel;
  final int messageId;

  LikabilityDto(
      {required this.userId,
      required this.characterId,
      required this.likingLevel,
      required this.messageId});

  factory LikabilityDto.fromJson(Map<String, dynamic> json) {
    return LikabilityDto(
        userId: json['user_id'],
        characterId: json['character_id'],
        likingLevel: json['liking_level'],
        messageId: json['message_id']);
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'character_id': characterId,
        'liking_level': likingLevel,
        'message_id': messageId
      };
}
