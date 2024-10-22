import 'package:palink_v2/domain/model/auth/login_model.dart';
import 'package:palink_v2/domain/model/auth/signup_model.dart';
import 'package:palink_v2/domain/model/user/user.dart';

abstract class AuthRepository {
  Future<User?> login(LoginModel loginModel);

  Future<User?> signUp(SignupModel signUpModel);

  Future<User?> getUserFromPreferences();
  Future<void> logout();
}
