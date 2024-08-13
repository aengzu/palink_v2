import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/liking/liking_request.dart';
import 'package:palink_v2/data/models/liking/liking_response.dart';
import 'package:retrofit/http.dart';

part 'liking_api.g.dart';


@RestApi()
abstract class LikingApi {
  factory LikingApi(Dio dio, {String baseUrl}) = _LikingApi;

  @POST("/likings")
  Future<LikingResponse> saveLiking(@Body() LikingRequest body);

  @GET("/likings/{liking_id}")
  Future<LikingResponse> getLikingById(@Path("liking_id") int likingId);

  @GET("/likings/messages/{message_id}")
  Future<List<LikingResponse>> getLikingsByMessageId(@Path("message_id") int messageId);

}
