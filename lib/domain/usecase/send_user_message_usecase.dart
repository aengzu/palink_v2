import 'package:palink_v2/data/mapper/message_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';

class SendUserMessageUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();
  final GenerateResponseUsecase generateResponseUsecase;

  SendUserMessageUsecase(
    this.generateResponseUsecase,
  );

  Future<Message?> saveUserMessage(String text, int chatRoomId) async {
    final messageRequest = _createMessageRequest(text);

    final messageResponse =
        await _saveMessageToServer(messageRequest, chatRoomId);

    return _mapResponseToDomain(messageResponse);
  }

  Future<Map<String?, AIResponse?>> generateAIResponse(
      int chatRoomId, Character character) async {
    return await generateResponseUsecase.execute(chatRoomId, character);
  }

  MessageRequest _createMessageRequest(String text) {
    return MessageRequest(
      sender: true,
      messageText: text,
      timestamp: DateTime.now().toIso8601String(),
    );
  }

  Future<MessageResponse?> _saveMessageToServer(
      MessageRequest messageRequest, int chatRoomId) async {
    return await chatRepository.saveMessage(chatRoomId, messageRequest);
  }

  Message? _mapResponseToDomain(MessageResponse? response) {
    return response?.toDomain();
  }
}
