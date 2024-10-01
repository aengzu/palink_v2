import 'package:json_annotation/json_annotation.dart';

part 'analysis_dto.g.dart'; // json_serializable을 사용하여 생성된 코드 파일

@JsonSerializable()
class AnalysisDto {
  final String evaluation;
  @JsonKey(name: 'final_rejection_score')
  final int finalRejectionScore;
  @JsonKey(name: 'final_affinity_score')
  final int finalAffinityScore;
  final String unachievedQuests;
  final String usedRejection;
  final String type;

  AnalysisDto({
    required this.evaluation,
    required this.finalRejectionScore,
    required this.finalAffinityScore,
    required this.unachievedQuests,
    required this.usedRejection,
    required this.type,
  });

  // JSON으로부터 AnalysisDTO 객체를 생성합니다.
  factory AnalysisDto.fromJson(Map<String, dynamic> json) => _$AnalysisDtoFromJson(json);

  // AnalysisDTO 객체를 JSON으로 변환합니다.
  Map<String, dynamic> toJson() => _$AnalysisDtoToJson(this);
}
