import 'package:json_annotation/json_annotation.dart';

part 'tip_dto.g.dart';

@JsonSerializable()
class TipDto {
  final String answer;
  final String reason;

  TipDto({required this.answer, required this.reason});

  factory TipDto.fromJson(Map<String, dynamic> json) => _$TipDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TipDtoToJson(this);
}
