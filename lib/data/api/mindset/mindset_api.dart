import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/emotion/emotion_create_request.dart';
import 'package:palink_v2/data/models/emotion/emotion_response.dart';
import 'package:palink_v2/data/models/mindset/mindset_response.dart';
import 'package:retrofit/http.dart';
part 'mindset_api.g.dart';


@RestApi()
abstract class MindsetApi {
  factory MindsetApi(Dio dio, {String baseUrl}) = _MindsetApi;


  @GET("/mindsets/random")
  Future<MindsetResponse?> getRandomMindset();

  @GET("/mindsets/{mindset_id}")
  Future<MindsetResponse> getMindsetById(@Path("mindset_id") int mindsetId);
}