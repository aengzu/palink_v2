abstract class UserRepository {
  Future<String> getUserId();
  Future<String> getName();
  Future<int> getAge();
  Future<String> getPersonalityType();
}
