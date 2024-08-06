import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/data/models/message_response.dart';
import 'package:palink_v2/domain/mapper/message_mapper.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';

class SendUserMessageUsecase {
  final ChatRepository chatRepository;
  final GenerateResponseUsecase generateResponseUsecase;

  SendUserMessageUsecase(this.chatRepository, this.generateResponseUsecase);

  Future<Message?> saveUserMessage(String text, int chatRoomId) async {
    MessageRequest messageRequest = MessageRequest(
      sender: true,
      messageText: text,
      timestamp: DateTime.now().toIso8601String(),
      conversationId: chatRoomId,
    );
    MessageResponse? response = await chatRepository.saveMessage(messageRequest);
    return response != null ? MessageMapper.toDomain(response) : null;
  }

  Future<Message?> generateAIResponse(int chatRoomId, Character character) async {
    AIResponse? aiResponse = await generateResponseUsecase.execute(chatRoomId, character);
    if (aiResponse != null) {
      MessageRequest messageRequest = MessageRequest(
        sender: false,
        messageText: aiResponse.text,
        timestamp: DateTime.now().toIso8601String(),
        conversationId: chatRoomId,
      );
      MessageResponse? response = await chatRepository.saveMessage(messageRequest);
      return response != null ? MessageMapper.toDomain(response) : null;
    }
    return null;
  }
}
