import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:palink_v2/domain/models/user.dart';
import 'package:palink_v2/utils/constants/app_url.dart';



class AuthService {
  final Dio _dio = Dio();
  final String _loginUrl = "${AppUrl().baseUrl}/api/user/login";
  final String _registerUrl = "${AppUrl().baseUrl}/api/user/register";

  Future<User?> login(String userId, String password) async {
    try {
      final response = await _dio.post(
        _loginUrl,
        data: jsonEncode({
          'user_id': userId,
          'password': password,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        print('Failed to login: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to login: $e');
      return null;
    }
  }

  Future<bool> signUp(UserSignDto userSignDto) async {
    try {
      final response = await _dio.post(
        _registerUrl,
        data: jsonEncode(userSignDto.toJson()),
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Failed to sign up: $e');
      return false;
    }
  }
}
