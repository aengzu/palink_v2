
import 'package:palink_v2/data/api/auth_api.dart';
import 'package:palink_v2/data/mapper/login_mapper.dart';
import 'package:palink_v2/data/mapper/signup_mapper.dart';
import 'package:palink_v2/data/mapper/user_mapper.dart';
import 'package:palink_v2/domain/entities/auth/login_model.dart';
import 'package:palink_v2/domain/entities/auth/signup_model.dart';
import 'package:palink_v2/domain/entities/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {

  final AuthApi _authApi;
  final SharedPreferences _prefs;
  AuthRepositoryImpl(this._authApi, this._prefs);


  @override
  Future<User?> login(LoginModel loginModel) async {
    try {
      final response = await _authApi.login(loginModel.toData());
      if (response != null) {
        // SharedPreferences에 사용자 정보 저장
        await _prefs.setString('accountId', response.accountId);
        await _prefs.setString('name', response.name);
        await _prefs.setInt('age', response.age);
        await _prefs.setString('personalityType', response.personalityType);

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
}