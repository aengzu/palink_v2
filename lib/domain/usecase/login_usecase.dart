import 'package:palink_v2/domain/model/auth/login_model.dart';
import 'package:palink_v2/domain/model/user/user.dart';

import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User?> execute(LoginModel loginModel) {
    return repository.login(loginModel);
  }

  Future<User?> checkAutoLogin() {
    return repository.getUserFromPreferences();
  }
}
