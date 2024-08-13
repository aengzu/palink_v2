import 'package:json_annotation/json_annotation.dart';

part 'rejection_request.g.dart';

@JsonSerializable()
class RejectionRequest {
  final int messageId;
  final int rejectionLevel;
  final int characterId;
  final int userId;
  final String rejectionText;

  RejectionRequest({
    required this.messageId,
    required this.rejectionLevel,
    required this.characterId,
    required this.userId,
    required this.rejectionText,
  });

  factory RejectionRequest.fromJson(Map<String, dynamic> json) => _$RejectionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RejectionRequestToJson(this);
}
