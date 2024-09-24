// data/model/user_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String accountId;
  final String name;
  final int age;
  final int userId;

  UserResponse({
    required this.accountId,
    required this.name,
    required this.age,
    required this.userId,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
