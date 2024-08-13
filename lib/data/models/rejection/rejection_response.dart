import 'package:json_annotation/json_annotation.dart';

part 'rejection_response.g.dart';

@JsonSerializable()
class RejectionResponse {
  final int messageId;
  final int rejectionLevel;
  final int characterId;
  final int userId;
  final String rejectionText;
  final int rejectionId;

  RejectionResponse({
    required this.messageId,
    required this.rejectionLevel,
    required this.characterId,
    required this.userId,
    required this.rejectionText,
    required this.rejectionId,
  });

  factory RejectionResponse.fromJson(Map<String, dynamic> json) => _$RejectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RejectionResponseToJson(this);
}
