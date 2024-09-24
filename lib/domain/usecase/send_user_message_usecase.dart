import 'package:palink_v2/data/mapper/message_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/usecase/generate_response_usecase.dart';

class SendUserMessageUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();
  final GenerateResponseUsecase generateResponseUsecase;

  late var userMessage;

  SendUserMessageUsecase(
    this.generateResponseUsecase,
  );

  Future<Message?> saveUserMessage(String text, int chatRoomId) async {
    final messageRequest = _createMessageRequest(text);
    userMessage = text;

    final messageResponse =
        await _saveMessageToServer(messageRequest, chatRoomId);

    return _mapResponseToDomain(messageResponse);
  }

  Future<Map<String?, dynamic?>> generateAIResponse(int chatRoomId,
      Character character, List<String> unachievedQuests) async {
    return await generateResponseUsecase.execute(
        chatRoomId, character, userMessage, unachievedQuests);
  }

  // 여기서 리턴할 때 isEnd 도 반환하고 싶다. AIResponse 와 합치지 않는다.
  MessageRequest _createMessageRequest(String text) {
    return MessageRequest(
        sender: true,
        messageText: text,
        timestamp: DateTime.now().toIso8601String(),
        aiResponse: AIResponse(
          text: text,
          feeling: "neutral",
          affinityScore: 0,
          rejectionScore: [],
          rejectionContent: [],
          finalRejectionScore: 0,
          finalAffinityScore: 0,
        ));
  }

  Future<MessageResponse?> _saveMessageToServer(
      MessageRequest messageRequest, int chatRoomId) async {
    return await chatRepository.saveMessage(chatRoomId, messageRequest);
  }

  Message? _mapResponseToDomain(MessageResponse? response) {
    return response?.toDomain();
  }
}
