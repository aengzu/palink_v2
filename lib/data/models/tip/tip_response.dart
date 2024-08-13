import 'package:json_annotation/json_annotation.dart';

part 'tip_response.g.dart';

@JsonSerializable()
class TipResponse {
  final int messageId;
  final String tipText;
  final int tipId;

  TipResponse({
    required this.messageId,
    required this.tipText,
    required this.tipId,
  });

  factory TipResponse.fromJson(Map<String, dynamic> json) => _$TipResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TipResponseToJson(this);
}
