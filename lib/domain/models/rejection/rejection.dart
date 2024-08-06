import 'package:json_annotation/json_annotation.dart';



class Rejection {
  final int rejectionId;
  final String userId;
  final int characterId;
  final int rejectionLevel;
  final int messageId;

  Rejection(
      {required this.rejectionId,
      required this.userId,
      required this.characterId,
      required this.rejectionLevel,
      required this.messageId});

  factory Rejection.fromJson(Map<String, dynamic> json) {
        return Rejection(
            rejectionId: json['rejection_id'],
            userId: json['user_id'],
            characterId: json['character_id'],
            rejectionLevel: json['rejection_level'],
            messageId: json['message_id']);
      }

  Map<String, dynamic> toJson() => {
        'rejection_id': rejectionId,
        'user_id': userId,
        'character_id': characterId,
        'rejection_level': rejectionLevel,
        'message_id': messageId
      };

}

class RejectionDto {
  final String userId;
  final int characterId;
  final int rejectionLevel;
  final int messageId;

  RejectionDto(
      {required this.userId,
      required this.characterId,
      required this.rejectionLevel,
      required this.messageId});

  factory RejectionDto.fromJson(Map<String, dynamic> json) {
    return RejectionDto(
        userId: json['user_id'],
        characterId: json['character_id'],
        rejectionLevel: json['rejection_level'],
        messageId: json['message_id']);
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'character_id': characterId,
        'rejection_level': rejectionLevel,
        'message_id': messageId
      };
}
