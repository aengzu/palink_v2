import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/conversation_response.dart';
import 'package:palink_v2/data/models/likinglevel_request.dart';
import 'package:palink_v2/data/models/likinglevel_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/models/message_response.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability/likability.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_service.g.dart';

@RestApi()
abstract class ChatService {
  factory ChatService(Dio dio, {String baseUrl}) = _ChatService;

  @POST("/api/conversation/create")
  Future<ConversationResponse> createConversation(@Body() ConversationRequest conversationRequest);

  @GET("/api/conversation/get_by_conversation_id")
  Future<ConversationResponse> getConversationById(@Query("conversation_id") int chatRoomId);

  @GET("/api/conversation/get_by_user_id")
  Future<List<ConversationResponse>> getConversationsByUserId(@Query("user_id") String userId);

  @POST("/api/message/create")
  Future<MessageResponse?> saveMessage(@Body() MessageRequest messageRequest);

  @GET("/api/message/get_by_conversation_id")
  Future<List<MessageResponse>> getMessagesByChatRoomId(@Query("conversation_id") int conversationId);

  @POST("/api/liking/create")
  Future<LikinglevelResponse> saveLikingLevel(@Body() LikinglevelRequest likinglevelRequest);
}
