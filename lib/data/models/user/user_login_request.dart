// data/model/user_create_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_login_request.g.dart';

@JsonSerializable()
class UserLoginRequest {
  final String accountId;
  final String password;

  UserLoginRequest({
    required this.accountId,
    required this.password,
  });

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) => _$UserLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRequestToJson(this);
}
