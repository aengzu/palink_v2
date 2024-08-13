import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/feedback/feedback_request.dart';
import 'package:palink_v2/data/models/feedback/feedback_response.dart';
import 'package:palink_v2/data/models/feedback/feedbacks_response.dart';
import 'package:retrofit/http.dart';

part 'feedback_api.g.dart';


@RestApi()
abstract class FeedbackApi {
  factory FeedbackApi(Dio dio, {String baseUrl}) = _FeedbackApi;

  @POST("/feedbacks")
  Future<FeedbackResponse> saveFeedback(@Body() FeedbackRequest feedbackRequest);

  @GET("/conversations/{conversation_id}/feedbacks")
  Future<FeedbacksResponse> getFeedbackByConversationId(@Path("conversation_id") int conversationId);

}
