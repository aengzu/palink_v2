import 'package:json_annotation/json_annotation.dart';

part 'tip_request.g.dart';

@JsonSerializable()
class TipRequest {
  final int messageId;
  final String tipText;

  TipRequest({
    required this.messageId,
    required this.tipText,
  });

  factory TipRequest.fromJson(Map<String, dynamic> json) => _$TipRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TipRequestToJson(this);
}
