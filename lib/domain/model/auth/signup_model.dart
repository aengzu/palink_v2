// domain/model/auth/signup_model.dart
class SignupModel {
  final String accountId;
  final String name;
  final int age;
  final String personalityType;
  final String password;

  SignupModel({
    required this.accountId,
    required this.name,
    required this.age,
    required this.personalityType,
    required this.password,
  });
}
