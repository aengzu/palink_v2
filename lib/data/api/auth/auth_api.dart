import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/user/user_create_request.dart';
import 'package:palink_v2/data/models/user/user_login_request.dart';
import 'package:palink_v2/data/models/user/user_response.dart';
import 'package:retrofit/http.dart';
part 'auth_api.g.dart';


@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;


  @POST("/login")
  Future<UserResponse?> login(@Body() UserLoginRequest body);

  @POST("/users")
  Future<UserResponse> signUp(@Body() UserCreateRequest body);

}