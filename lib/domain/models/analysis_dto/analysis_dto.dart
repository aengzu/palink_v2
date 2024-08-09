import 'package:json_annotation/json_annotation.dart';

part 'analysis_dto.g.dart'; // json_serializable을 사용하여 생성된 코드 파일

@JsonSerializable()
class AnalysisDto {
  final String evaluation;
  @JsonKey(name: 'used_rejection')
  final String usedRejection;
  @JsonKey(name: 'final_rejection_score')
  final int finalRejectionScore;

  AnalysisDto({
    required this.evaluation,
    required this.usedRejection,
    required this.finalRejectionScore,
  });

  // JSON으로부터 AnalysisDTO 객체를 생성합니다.
  factory AnalysisDto.fromJson(Map<String, dynamic> json) => _$AnalysisDtoFromJson(json);

  // AnalysisDTO 객체를 JSON으로 변환합니다.
  Map<String, dynamic> toJson() => _$AnalysisDtoToJson(this);
}
