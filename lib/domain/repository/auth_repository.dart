
import 'package:palink_v2/domain/entities/auth/login_model.dart';
import 'package:palink_v2/domain/entities/auth/signup_model.dart';
import 'package:palink_v2/domain/entities/user/user.dart';

abstract class AuthRepository {
  Future<User?> login(LoginModel loginModel);
  Future<User?> signUp(SignupModel signUpModel);
}