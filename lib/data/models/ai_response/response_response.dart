import 'package:json_annotation/json_annotation.dart';

part 'response_response.g.dart';

@JsonSerializable()
class ResponseResponse {
  final String text;
  final bool isEnd;

  ResponseResponse({
    required this.text,
    required this.isEnd,
  });

  factory ResponseResponse.fromJson(Map<String, dynamic> json) => _$ResponseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseResponseToJson(this);
}
