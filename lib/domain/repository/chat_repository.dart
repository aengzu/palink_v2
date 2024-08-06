// domain/repositories/chat_repository.dart
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/conversation_response.dart';
import 'package:palink_v2/data/models/likinglevel_request.dart';
import 'package:palink_v2/data/models/likinglevel_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/models/message_response.dart';

abstract class ChatRepository {
  Future<ConversationResponse> createConversation(ConversationRequest conversationRequest);
  Future<MessageResponse?> saveMessage(MessageRequest messageRequest);
  Future<MessageResponse?> saveAIResponseAsMessage(AIResponse aiResponse, int conversationId);
  Future<LikinglevelResponse> saveLikingLevel(LikinglevelRequest likinglevelRequest);
  Future<List<MessageResponse>> fetchMessagesByChatRoomId(int chatRoomId);
  Future<ConversationResponse> fetchConversationByChatRoomId(int chatRoomId);
}
