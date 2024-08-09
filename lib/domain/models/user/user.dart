import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  @JsonKey(name: 'user_id')
  final String userId;
  final int age;
  @JsonKey(name: 'personality_type')
  final String personalityType;

  User({
    required this.userId,
    required this.name,
    required this.age,
    required this.personalityType,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

