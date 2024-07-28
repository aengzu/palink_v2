import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {
  @JsonKey(name: 'user_id')
  final String userId;
  final String password;
  final String name;
  final int age;
  @JsonKey(name: 'personality_type')
  final String personalityType;

  SignupModel({
    required this.userId,
    required this.password,
    required this.name,
    required this.age,
    required this.personalityType,
  });

  // SignupModel 인스턴스를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
