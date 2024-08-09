import 'package:palink_v2/domain/models/user/user.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';

class GetUserInfoUseCase {
  final UserRepository userRepository;

  GetUserInfoUseCase(this.userRepository);

  Future<User> execute() async {
    String userId = await userRepository.getUserId();
    String name = await userRepository.getName();
    int age = await userRepository.getAge();
    String personalityType = await userRepository.getPersonalityType();

    return User(
      userId: userId,
      name: name,
      age: age,
      personalityType: personalityType,
    );
  }
}
