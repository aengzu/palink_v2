// domain/entities/user/user.dart
class User {
  final String accountId;
  final String name;
  final int age;
  final String personalityType;
  int? userId;

  User({
    required this.accountId,
    required this.name,
    required this.age,
    required this.personalityType,
    this.userId,
  });
}
