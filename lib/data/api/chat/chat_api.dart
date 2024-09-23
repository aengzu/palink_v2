// data/api/chat_api.dart
import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/data/models/chat/conversation_request.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/data/models/chat/conversations_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/data/models/chat/messages_response.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_api.g.dart';

@RestApi()
abstract class ChatApi {
  factory ChatApi(Dio dio, {String baseUrl}) = _ChatApi;

  @POST("/conversations")
  Future<ConversationResponse> createConversation(@Body() ConversationRequest conversationRequest);

  @GET("/conversations/{conversation_id}")
  Future<ConversationResponse> getConversationById(@Path("conversation_id") int conversationId);

  @GET("/conversations/users/{user_id}")
  Future<ConversationsResponse> getConversationsByUserId(@Path("user_id") int userId);

  @POST("/conversations/{conversation_id}/messages")
  Future<MessageResponse?> saveMessage(@Path("conversation_id") int conversationId, @Body() MessageRequest messageRequest);

  @GET("/conversations/{conversation_id}/messages")
  Future<MessagesResponse?> getMessagesByChatRoomId(@Path("conversation_id") int conversationId);

  @GET("/conversations/{conversation_id}/messages/{message_id}")
  Future<MessageResponse> getMessageById(@Path("conversation_id") int conversationId, @Path("message_id") int messageId);

  @GET("/conversations/{conversation_id}/airesponses")
  Future<List<AIResponseResponse>> getAIResponsesByConversationId(@Path("conversation_id") int conversationId);

  @GET("/conversations/{conversation_id}/messages/{message_id}/airesponses")
  Future<List<AIResponseResponse>> getAIResponsesByMessageId(@Path("conversation_id") int conversationId, @Path("message_id") int messageId);
}
