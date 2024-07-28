// login_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: 'user_id')
  final String userId;
  final String password;

  LoginModel({required this.userId, required this.password});

  // LoginModel 인스턴스를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
