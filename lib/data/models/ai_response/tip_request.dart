import 'package:json_annotation/json_annotation.dart';

part 'tip_request.g.dart';

@JsonSerializable()
class TipRequest {
  final String message;
  final List<String> unachievedQuests;

  TipRequest({
    required this.message,
    required this.unachievedQuests,
  });

  factory TipRequest.fromJson(Map<String, dynamic> json) =>
      _$TipRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TipRequestToJson(this);
}
