import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  final String text;
  final bool isEnd;
  final int affinityScore;
  final String feeling;

  ChatResponse({
    required this.text,
    required this.isEnd,
    required this.affinityScore,
    required this.feeling,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) => _$ChatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
