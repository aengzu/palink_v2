import 'package:palink_v2/domain/model/user/user.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';

class GetUserInfoUseCase {
  final UserRepository userRepository;

  GetUserInfoUseCase(this.userRepository);

  Future<User?> execute() async {
    int? userId = userRepository.getUserId();
    User? user = await userRepository.getUser(userId!);
    return user;
  }
}
