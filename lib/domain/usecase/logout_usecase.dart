import 'package:palink_v2/domain/model/auth/login_model.dart';
import 'package:palink_v2/domain/model/user/user.dart';

import '../repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  Future<void> execute() {
    return repository.logout();
  }
}
