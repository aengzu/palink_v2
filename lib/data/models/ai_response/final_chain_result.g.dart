// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_chain_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalChainResult _$FinalChainResultFromJson(Map<String, dynamic> json) =>
    FinalChainResult(
      message: ChatResponse.fromJson(json['message'] as Map<String, dynamic>),
      likability:
          LikingResponse.fromJson(json['likability'] as Map<String, dynamic>),
      rejection:
          RejectionResponse.fromJson(json['rejection'] as Map<String, dynamic>),
      tip: TipResponse.fromJson(json['tip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinalChainResultToJson(FinalChainResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'likability': instance.likability,
      'rejection': instance.rejection,
      'tip': instance.tip,
    };
