// data/model/user_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_collection_response.g.dart';

@JsonSerializable()
class UserCollectionResponse {
  final int characterId;
  final String addedDate;
  final int userId;

  UserCollectionResponse({
    required this.characterId,
    required this.addedDate,
    required this.userId,
  });

  factory UserCollectionResponse.fromJson(Map<String, dynamic> json) => _$UserCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserCollectionResponseToJson(this);
}
