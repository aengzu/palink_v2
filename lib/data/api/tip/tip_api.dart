import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/tip/tip_create_request.dart';
import 'package:palink_v2/data/models/tip/tip_response.dart';
import 'package:retrofit/http.dart';

part 'tip_api.g.dart';


@RestApi()
abstract class TipApi {
  factory TipApi(Dio dio, {String baseUrl}) = _TipApi;

  @POST("/tips")
  Future<TipResponse> saveTip(@Body() TipCreateRequest tipCreateRequest);

  @GET("/tips/{tip_id}")
  Future<TipResponse> getTipById(@Path("tip_id") int tipId);

  @GET("/tips/messages/{message_id}")
  Future<List<TipResponse>> getTipsByMessageId(@Path("message_id") int messageId);

}
