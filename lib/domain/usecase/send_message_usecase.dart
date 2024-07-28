import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<Message?> execute(String text, int conversationId) {
    return _chatRepository.sendUserMessage(text, conversationId);
  }
}
