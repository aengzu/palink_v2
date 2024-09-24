// domain/model/user/user.dart
class User {
  final String accountId;
  final String name;
  final int age;
  int? userId;

  User({
    required this.accountId,
    required this.name,
    required this.age,
    this.userId,
  });
}
