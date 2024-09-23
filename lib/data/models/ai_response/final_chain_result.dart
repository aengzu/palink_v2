import 'package:json_annotation/json_annotation.dart';
import 'package:palink_v2/data/models/ai_response/chat_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';
import 'package:palink_v2/data/models/ai_response/tip_response.dart';

part 'final_chain_result.g.dart';

@JsonSerializable()
class FinalChainResult {
  final ChatResponse message;
  final LikingResponse likability;
  final RejectionResponse rejection;
  final TipResponse tip;

  FinalChainResult({
    required this.message,
    required this.likability,
    required this.rejection,
    required this.tip,
  });

  factory FinalChainResult.fromJson(Map<String, dynamic> json) =>
      _$FinalChainResultFromJson(json);
  Map<String, dynamic> toJson() => _$FinalChainResultToJson(this);
}
