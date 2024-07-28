
import 'package:palink_v2/core/utils/message_utils.dart';
import 'package:palink_v2/data/services/chat_service.dart';
import 'package:palink_v2/domain/models/chat/ai_response.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability.dart';



class ChatRepository {
  final ChatService _chatService = ChatService();

  Future<Conversation> createConversation(
      ConversationDto conversationDto) async {
    return await _chatService.createConversation(conversationDto);
  }

  Future<Message?> sendMessage(MessageDto messageDto) async {
    return await _chatService.sendMessage(messageDto);
  }

  Future<Message?> sendAIResponseAsMessage(
      AIResponse aiResponse, int conversationId) async {
    MessageDto messageDto =
        MessageUtils.convertAIMessageToMessageDto(aiResponse, conversationId);
    return await sendMessage(messageDto);
  }

  Future<Likability> sendLikingLevel(
      String userId, int characterId, int likingLevel, int messageId) async {
    return await _chatService.sendLikingLevel(
        userId, characterId, likingLevel, messageId);
  }

  Future<List<Message>> getMessagesByChatRoomId(int chatRoomId) async {
    return await _chatService.getMessagesByChatRoomId(chatRoomId);
  }

  Future<Message?> sendUserMessage(String text, int conversationId) async {
    MessageDto messageDto =
        MessageUtils.createUserMessageDto(text, conversationId);
    return await sendMessage(messageDto);
  }
}
