import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_service.g.dart';

@RestApi()
abstract class ChatService {
  factory ChatService(Dio dio, {String baseUrl}) = _ChatService;

  @POST("/api/conversation/create")
  Future<Conversation> createConversation(@Body() ConversationRequest conversationRequest);

  @GET("/api/conversation/get_by_conversation_id")
  Future<Conversation> getChatRoomById(@Query("conversation_id") int chatRoomId);

  @GET("/api/conversation/get_by_user_id")
  Future<List<Conversation>> getConversationsByUserId(@Query("user_id") String userId);

  @POST("/api/message/create")
  Future<Message?> sendMessage(@Body() MessageRequest messageRequest);

  @GET("/api/message/get_by_conversation_id")
  Future<List<Message>> getMessagesByChatRoomId(@Query("conversation_id") int conversationId);

  @POST("/api/liking/create")
  Future<Likability> sendLikingLevel(
      @Field("user_id") String userId,
      @Field("character_id") int characterId,
      @Field("liking_level") int likingLevel,
      @Field("message_id") int messageId,
      );
}
