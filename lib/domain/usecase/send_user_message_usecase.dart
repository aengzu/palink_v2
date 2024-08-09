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

    // 유저의 메시지를 서버에 저장
    MessageResponse? response = await chatRepository.saveMessage(messageRequest);
    print(response);
    return response != null ? MessageMapper.toDomain(response) : null;
  }

  Future<AIResponse?> generateAIResponse(int chatRoomId, Character character) async {
    // AI의 응답을 생성
    AIResponse? aiResponse = await generateResponseUsecase.execute(chatRoomId, character);
    return aiResponse;
  }
}
