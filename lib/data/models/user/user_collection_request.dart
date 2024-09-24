// data/model/user_create_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_collection_request.g.dart';

@JsonSerializable()
class UserCollectionRequest {
  final int characterId;
  final String addedDate;

  UserCollectionRequest({
    required this.characterId,
    required this.addedDate,
  });

  factory UserCollectionRequest.fromJson(Map<String, dynamic> json) => _$UserCollectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserCollectionRequestToJson(this);
}
