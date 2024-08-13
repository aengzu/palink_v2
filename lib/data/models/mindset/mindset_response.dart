import 'package:json_annotation/json_annotation.dart';

part 'mindset_response.g.dart';

@JsonSerializable()
class MindsetResponse {
  final String mindsetText;
  final int mindsetId;

  MindsetResponse({
    required this.mindsetText,
    required this.mindsetId,
  });

  factory MindsetResponse.fromJson(Map<String, dynamic> json) => _$MindsetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MindsetResponseToJson(this);
}
