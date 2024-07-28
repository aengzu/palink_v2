import 'package:dio/dio.dart';
import 'package:palink_v2/domain/models/user.dart';
import 'package:retrofit/http.dart';
part 'auth_service.g.dart';


@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  static const String _loginEndpoint = "/api/user/login";
  static const String _registerEndpoint = "/api/user/register";


  @POST(_loginEndpoint)
  Future<User?> login(@Body() Map<String, dynamic> body);


  @POST(_registerEndpoint)
  Future<User> signUp(@Body() Map<String, dynamic> body);

}