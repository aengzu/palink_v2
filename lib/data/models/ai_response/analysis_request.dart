import 'package:json_annotation/json_annotation.dart';

part 'analysis_request.g.dart';

// TODO : AnalysisResponse 모델 작성
@JsonSerializable()
class AnalysisRequest {
  final String chatHistory;
  final String description;
  final int finalRejectionScore;

  AnalysisRequest({
    required this.chatHistory,
    required this.description,
    required this.finalRejectionScore,
  });

  factory AnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$AnalysisRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisRequestToJson(this);
}
