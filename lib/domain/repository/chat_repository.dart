// domain/repositories/chat_repository.dart
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/data/models/chat/conversation_request.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/data/models/chat/messages_response.dart';

abstract class ChatRepository {
  Future<ConversationResponse> createConversation(ConversationRequest conversationRequest);
  Future<MessageResponse?> saveMessage(int conversationId, MessageRequest messageRequest);
  Future<MessageResponse?> saveAIResponseAsMessage(AIResponse aiResponse, int conversationId);
  Future<MessagesResponse?> fetchMessagesByChatRoomId(int chatRoomId);
  Future<ConversationResponse> fetchConversationByChatRoomId(int chatRoomId);
  Future<AIResponseResponse> fetchAIResponseByMessageId(int conversationId, int messageId);
}
