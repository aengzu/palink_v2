import 'package:palink_v2/domain/repository/user_repository.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase(this.userRepository);

  Future<String> getUserId() {
    return userRepository.getUserId();
  }

  Future<String> getName() {
    return userRepository.getName();
  }

  Future<int> getAge() {
    return userRepository.getAge();
  }

  Future<String> getPersonalityType() {
    return userRepository.getPersonalityType();
  }
}
