import 'package:json_annotation/json_annotation.dart';

part 'tip_response.g.dart';

@JsonSerializable()
class TipResponse {
  final String answer;
  final String reason;

  TipResponse({
    required this.answer,
    required this.reason,
  });

  factory TipResponse.fromJson(Map<String, dynamic> json) =>
      _$TipResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TipResponseToJson(this);
}
