import '../entities/user/user.dart';

abstract class UserRepository {
  int? getUserId();
  Future<User?> getUser(int userId);
}
