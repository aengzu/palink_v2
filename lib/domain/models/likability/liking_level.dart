import 'package:json_annotation/json_annotation.dart';
part 'liking_level.g.dart';

@JsonSerializable()
class LikingLevel {
  final int likingLevel;
  final int messageId;

  LikingLevel({required this.likingLevel, required this.messageId});

  factory LikingLevel.fromJson(Map<String, dynamic> json) => _$LikingLevelFromJson(json);

  Map<String, dynamic> toJson() => _$LikingLevelToJson(this);
}
