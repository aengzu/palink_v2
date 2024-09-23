import 'package:json_annotation/json_annotation.dart';

part 'analysis_response.g.dart';

// TODO : AnalysisResponse 모델 작성
@JsonSerializable()
class AnalysisResponse {
  final String evaluation;
  final String usedRejection;

  AnalysisResponse({
    required this.evaluation,
    required this.usedRejection,
  });

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisResponseToJson(this);
}