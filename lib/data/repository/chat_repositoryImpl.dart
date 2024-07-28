import 'package:palink_v2/core/utils/message_utils.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/services/chat_service.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatService _chatService;

  ChatRepositoryImpl(this._chatService);

  @override
  Future<Conversation> createConversation(ConversationRequest conversationRequest) {
    print('createConversation');
    return _chatService.createConversation(conversationRequest);
  }

  @override
  Future<Message?> sendMessage(MessageRequest messageRequest) {
    return _chatService.sendMessage(messageRequest);
  }

  @override
  Future<Message?> sendAIResponseAsMessage(AIResponse aiResponse, int conversationId) {
    MessageRequest messageDto = MessageUtils.convertAIMessageToMessageDto(aiResponse, conversationId);
    return sendMessage(messageDto);
  }

  @override
  Future<Likability> sendLikingLevel(String userId, int characterId, int likingLevel, int messageId) {
    return _chatService.sendLikingLevel(userId, characterId, likingLevel, messageId);
  }

  @override
  Future<List<Message>> getMessagesByChatRoomId(int chatRoomId) {
    return _chatService.getMessagesByChatRoomId(chatRoomId);
  }

  @override
  Future<Message?> sendUserMessage(String text, int conversationId) {
    MessageRequest messageDto = MessageUtils.createUserMessageDto(text, conversationId);
    return sendMessage(messageDto);
  }
}
