import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/liking/liking_request.dart';
import 'package:palink_v2/data/models/liking/liking_response.dart';
import 'package:palink_v2/data/models/rejection/rejection_request.dart';
import 'package:palink_v2/data/models/rejection/rejection_response.dart';
import 'package:retrofit/http.dart';

part 'rejection_api.g.dart';


@RestApi()
abstract class RejectionApi {
  factory RejectionApi(Dio dio, {String baseUrl}) = _RejectionApi;

  @POST("/rejections")
  Future<RejectionResponse> saveRejection(@Body() RejectionRequest body);

  @GET("/rejections/conversations/{conversation_id}")
  Future<List<RejectionResponse>> getRejectionsByConversationId(@Path("conversation_id") int conversationId);

  @GET("/rejections/messages/{message_id}")
  Future<List<RejectionResponse>> getRejectionsByMessageId(@Path("message_id") int messageId);

}
