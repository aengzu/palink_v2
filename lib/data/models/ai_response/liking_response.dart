import 'package:json_annotation/json_annotation.dart';

part 'liking_response.g.dart';

@JsonSerializable()
class LikingResponse {
  final String feeling;
  final int likability;

  LikingResponse({
    required this.feeling,
    required this.likability,
  });

  factory LikingResponse.fromJson(Map<String, dynamic> json) =>
      _$LikingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LikingResponseToJson(this);
}
