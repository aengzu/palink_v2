import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/message_request.dart';

abstract class ChatRepository {
  Future<Conversation> createConversation(ConversationRequest conversationRequest);
  Future<Message?> sendMessage(MessageRequest messageRequest);
  Future<Message?> sendAIResponseAsMessage(AIResponse aiResponse, int conversationId);
  Future<Likability> sendLikingLevel(String userId, int characterId, int likingLevel, int messageId);
  Future<List<Message>> getMessagesByChatRoomId(int chatRoomId);
  Future<Message?> sendUserMessage(String text, int conversationId);
}
