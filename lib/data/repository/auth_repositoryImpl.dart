import 'package:palink_v2/data/api/auth/auth_api.dart';
import 'package:palink_v2/data/api/user/user_api.dart';
import 'package:palink_v2/data/mapper/login_mapper.dart';
import 'package:palink_v2/data/mapper/signup_mapper.dart';
import 'package:palink_v2/data/mapper/user_mapper.dart';
import 'package:palink_v2/domain/model/auth/login_model.dart';
import 'package:palink_v2/domain/model/auth/signup_model.dart';
import 'package:palink_v2/domain/model/user/user.dart';
import 'package:palink_v2/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final UserApi _userApi;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._authApi, this._userApi, this._prefs);

  @override
  Future<User?> login(LoginModel loginModel) async {
    try {
      final response = await _authApi.login(loginModel.toData());
      if (response != null) {
        // SharedPreferences에 userId 와 로그인 여부 저장
        await _prefs.setInt('userId', response.userId);
        await _prefs.setBool('isLoggedIn', true);
        return response.toDomain();
      }
      return null;
    } catch (e) {
      print('Error in login: $e');
      return null;
    }
  }

  @override
  Future<User?> signUp(SignupModel signUpModel) async {
    try {
      final response = await _authApi.signUp(signUpModel.toData());
      return response?.toDomain();
    } catch (e) {
      print('Error in sign up: $e');
      return null;
    }
  }

  @override
  Future<User?> getUserFromPreferences() async {
    try {
      final userId = _prefs.getInt('userId');
      final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn && userId != null) {
        final userResponse = await _userApi.getUserById(userId);
        return userResponse?.toDomain();
      }
      return null;
    } catch (e) {
      print('Error in getUserFromPreferences: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _prefs.remove('userId');
    await _prefs.remove('isLoggedIn');
  }
}
