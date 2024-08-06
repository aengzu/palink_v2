// data/repositories/chat_repository_impl.dart
import 'package:palink_v2/core/utils/message_utils.dart';
import 'package:palink_v2/data/api/chat_api.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/conversation_request.dart';
import 'package:palink_v2/data/models/conversation_response.dart';
import 'package:palink_v2/data/models/likinglevel_request.dart';
import 'package:palink_v2/data/models/likinglevel_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/models/message_response.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';


class ChatRepositoryImpl implements ChatRepository {
  final ChatApi chatApi;

  ChatRepositoryImpl(this.chatApi);

  @override
  Future<ConversationResponse> createConversation(ConversationRequest conversationRequest) {
    return chatApi.createConversation(conversationRequest);
  }

  @override
  Future<MessageResponse?> saveMessage(MessageRequest messageRequest) {
    return chatApi.saveMessage(messageRequest);
  }

  @override
  Future<MessageResponse?> saveAIResponseAsMessage(AIResponse aiResponse, int conversationId) {
    final messageRequest = MessageUtils.convertAIMessageToMessageDto(aiResponse, conversationId);
    return saveMessage(messageRequest);
  }

  @override
  Future<LikinglevelResponse> saveLikingLevel(LikinglevelRequest likinglevelRequest) {
    return chatApi.saveLikingLevel(likinglevelRequest);
  }

  @override
  Future<List<MessageResponse>> fetchMessagesByChatRoomId(int chatRoomId) {
    return chatApi.getMessagesByChatRoomId(chatRoomId);
  }

  @override
  Future<ConversationResponse> fetchConversationByChatRoomId(int conversationId) {
    return chatApi.getConversationById(conversationId);
  }
}
