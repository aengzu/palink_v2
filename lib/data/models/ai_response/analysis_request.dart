import 'package:json_annotation/json_annotation.dart';

part 'analysis_request.g.dart';

// TODO : AnalysisResponse 모델 작성
@JsonSerializable()
class AnalysisRequest {
  final String chatHistory;
  final String quest;
  final String rejectionContent;

  AnalysisRequest({
    required this.chatHistory,
    required this.quest,
    required this.rejectionContent
  });

  factory AnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$AnalysisRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisRequestToJson(this);
}
