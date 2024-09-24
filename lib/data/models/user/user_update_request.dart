// data/model/user_create_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable()
class UserUpdateRequest {
  final String name;
  final String password;
  final int age;

  UserUpdateRequest({
    required this.name,
    required this.password,
    required this.age,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
