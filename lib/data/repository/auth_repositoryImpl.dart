import 'package:palink_v2/domain/models/auth/login_model.dart';
import 'package:palink_v2/domain/models/auth/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthService _authService;
  final SharedPreferences _prefs;
  AuthRepositoryImpl(this._authService, this._prefs);


  @override
  Future<User?> login(LoginModel loginModel) async {
    try {
      final response = await _authService.login(loginModel.toJson());
      if (response != null) {
        // SharedPreferences에 사용자 정보 저장
        await _prefs.setString('userId', response.userId);
        await _prefs.setString('name', response.name);
        await _prefs.setInt('age', response.age);
        await _prefs.setString('personalityType', response.personalityType);

        return response;
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
      return await _authService.signUp(signUpModel.toJson());
    } catch (e) {
      print('Error in sign up: $e');
      return null;
    }
  }
}