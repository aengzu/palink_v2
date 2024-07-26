import 'package:json_annotation/json_annotation.dart';

class User {
  final String name;
  final String userId;
  final int age;
  final String personalityType;

  User({
    required this.name,
    required this.userId,
    required this.age,
    required this.personalityType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      userId: json['user_id'],
      age: json['age'],
      personalityType: json['personality_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user_id': userId,
      'age': age,
      'personality_type': personalityType,
    };
  }
}



// UserSignDto 클래스
@JsonSerializable()
class UserSignDto {
  final String userId;
  final String name;
  final String password;
  final int age;
  final String personalityType;

  UserSignDto({
    required this.userId,
    required this.name,
    required this.password,
    required this.age,
    required this.personalityType,
  });

  factory UserSignDto.fromJson(Map<String, dynamic> json) {
    return UserSignDto(
      userId: json['user_id'],
      name: json['name'],
      password: json['password'],
      age: json['age'],
      personalityType: json['personality_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'password': password,
      'age': age,
      'personality_type': personalityType,
    };
  }

  // UserSignDto를 User 엔티티로 변환하는 메소드
  User toUser() {
    return User(
      name: name,
      userId: userId,
      age: age,
      personalityType: personalityType,
    );
  }
}

// User 엔티티에서 UserSignDto로 변환하는 메소드
extension UserToDto on User {
  UserSignDto toUserSignDto(String password) {
    return UserSignDto(
      userId: userId,
      name: name,
      password: password,
      age: age,
      personalityType: personalityType,
    );
  }
}

@JsonSerializable()
class LoginDto {
  final String userId;
  final String password;

  LoginDto({
    required this.userId,
    required this.password,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      userId: json['user_id'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'password': password,
    };
  }
}
