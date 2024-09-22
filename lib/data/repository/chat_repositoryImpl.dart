// data/repositories/chat_repository_impl.dart
import 'package:palink_v2/core/utils/message_utils.dart';
import 'package:palink_v2/data/api/chat/chat_api.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/data/models/chat/conversation_request.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/data/models/chat/messages_response.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

// ChatRepositoryImpl.dart

class ChatRepositoryImpl implements ChatRepository {
  final ChatApi chatApi;

  ChatRepositoryImpl(this.chatApi);

  @override
  Future<ConversationResponse> createConversation(ConversationRequest conversationRequest) {
    return chatApi.createConversation(conversationRequest);
  }

  @override
  Future<MessageResponse?> saveMessage(int conversationId, MessageRequest messageRequest) {
    return chatApi.saveMessage(conversationId, messageRequest);
  }

  @override
  Future<MessageResponse?> saveAIResponseAsMessage(AIResponse aiResponse, int conversationId) {
    final messageRequest = MessageUtils.convertAIMessageToMessageRequest(aiResponse);
    return saveMessage(conversationId, messageRequest);
  }

  @override
  Future<MessagesResponse?> fetchMessagesByChatRoomId(int chatRoomId) {
    return chatApi.getMessagesByChatRoomId(chatRoomId);
  }

  @override
  Future<ConversationResponse> fetchConversationByChatRoomId(int conversationId) {
    return chatApi.getConversationById(conversationId);
  }

  @override
  Future<AIResponseResponse> fetchAIResponseByMessageId(int conversationId, int messageId) {
    return chatApi.getAIResponsesByMessageId(conversationId, messageId);
  }


}

