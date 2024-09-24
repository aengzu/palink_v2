// data/mappers/signup_mapper.dart
import 'package:palink_v2/data/models/user/user_create_request.dart';
import 'package:palink_v2/domain/model/auth/signup_model.dart';

extension SignupMapper on SignupModel {
  UserCreateRequest toData() {
    return UserCreateRequest(
      accountId: accountId,
      name: name,
      age: age,
      password: password,
    );
  }
}
