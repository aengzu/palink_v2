import 'package:dio/dio.dart';
import 'package:palink_v2/domain/models/user/user.dart';
import 'package:retrofit/http.dart';
part 'auth_api.g.dart';


@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  static const String _loginEndpoint = "/api/user/login";
  static const String _registerEndpoint = "/api/user/register";


  @POST(_loginEndpoint)
  Future<User?> login(@Body() Map<String, dynamic> body);


  @POST(_registerEndpoint)
  Future<User> signUp(@Body() Map<String, dynamic> body);

}