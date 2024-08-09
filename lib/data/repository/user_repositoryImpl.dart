// data/repository/shared_pref_user_repository.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SharedPreferences prefs;

  UserRepositoryImpl(this.prefs);

  @override
  Future<String> getUserId() async {
    final userId = prefs.getString('userId') ?? '';
    print('Retrieved userId: $userId');
    return userId;
  }

  @override
  Future<String> getName() async {
    final name = prefs.getString('name') ?? '';
    print('Retrieved name: $name');
    return name;
  }

  @override
  Future<int> getAge() async {
    final age = prefs.getInt('age') ?? 0;
    print('Retrieved age: $age');
    return age;
  }

  @override
  Future<String> getPersonalityType() async {
    final personalityType = prefs.getString('personalityType') ?? '';
    print('Retrieved personalityType: $personalityType');
    return personalityType;
  }
}
