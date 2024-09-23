import 'package:json_annotation/json_annotation.dart';

part 'rejection_response.g.dart';

@JsonSerializable()
class RejectionResponse {
  final List<String> rejectionContent;

  RejectionResponse({
    required this.rejectionContent,
  });

  factory RejectionResponse.fromJson(Map<String, dynamic> json) =>
      _$RejectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RejectionResponseToJson(this);
}
