import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/user/user_collection_request.dart';
import 'package:palink_v2/data/models/user/user_collection_response.dart';
import 'package:palink_v2/data/models/user/user_response.dart';
import 'package:palink_v2/data/models/user/user_update_request.dart';
import 'package:retrofit/http.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/users/{user_id}")
  Future<UserResponse?> getUserById(@Path("user_id") int userId);

  @PATCH("/users/{user_id}")
  Future<UserResponse> updateUserById(
      @Path("user_id") int userId, @Body() UserUpdateRequest body);

  @POST("/users/{user_id}/collections")
  Future<UserCollectionResponse> addUserCollection(
      @Path("user_id") int userId, @Body() UserCollectionRequest body);

  @GET("/users/{user_id}/collections")
  Future<List<UserCollectionResponse>> getUserCollections(
      @Path("user_id") int userId);
}
