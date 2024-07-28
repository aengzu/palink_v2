import 'package:palink_v2/domain/models/auth/login_model.dart';
import 'package:palink_v2/domain/models/auth/signup_model.dart';

import '../models/user.dart';

abstract class AuthRepository {
  Future<User?> login(LoginModel loginModel);
  Future<User?> signUp(SignupModel signUpModel);
}