// data/model/user_create_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_create_request.g.dart';

@JsonSerializable()
class UserCreateRequest {
  final String accountId;
  final String name;
  final int age;
  final String password;

  UserCreateRequest({
    required this.accountId,
    required this.name,
    required this.age,
    required this.password,
  });

  factory UserCreateRequest.fromJson(Map<String, dynamic> json) => _$UserCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateRequestToJson(this);
}
