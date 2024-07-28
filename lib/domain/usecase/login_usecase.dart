import 'package:palink_v2/domain/models/auth/login_model.dart';
import 'package:palink_v2/domain/models/user.dart';

import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User?> execute(LoginModel loginModel) {
    return repository.login(loginModel);
  }
}