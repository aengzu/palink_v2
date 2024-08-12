
import 'package:palink_v2/domain/entities/auth/signup_model.dart';
import 'package:palink_v2/domain/entities/user/user.dart';
import 'package:palink_v2/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<User?> execute(SignupModel signUpModel) {
    return repository.signUp(signUpModel);
  }
}
