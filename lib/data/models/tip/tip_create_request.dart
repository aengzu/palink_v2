import 'package:json_annotation/json_annotation.dart';

part 'tip_create_request.g.dart';

@JsonSerializable()
class TipCreateRequest {
  final int messageId;
  final String tipText;

  TipCreateRequest({
    required this.messageId,
    required this.tipText,
  });

  factory TipCreateRequest.fromJson(Map<String, dynamic> json) => _$TipCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TipCreateRequestToJson(this);
}
