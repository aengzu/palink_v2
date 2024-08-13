import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/emotion/emotion_create_request.dart';
import 'package:palink_v2/data/models/emotion/emotion_response.dart';
import 'package:retrofit/http.dart';
part 'emotion_api.g.dart';


@RestApi()
abstract class EmotionApi {
  factory EmotionApi(Dio dio, {String baseUrl}) = _EmotionApi;


  @POST("/emotions")
  Future<EmotionResponse?> saveEmotion(@Body() EmotionCreateRequest body);

  @GET("/emotion/{emotion_id}")
  Future<EmotionResponse> getEmotionById(@Path("emotion_id") int emotionId);

  @GET("/emotions/messages/{message_id}")
  Future<List<EmotionResponse>> getEmotionsByMessageId(@Path("message_id") int messageId);

}