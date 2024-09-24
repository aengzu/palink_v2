// data/mappers/login_mapper.dart
import 'package:palink_v2/data/models/user/user_login_request.dart';
import 'package:palink_v2/domain/model/auth/login_model.dart';

extension LoginMapper on LoginModel {
  UserLoginRequest toData() {
    return UserLoginRequest(
      accountId: accountId,
      password: password,
    );
  }
}
