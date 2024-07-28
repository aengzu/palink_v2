import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _chatRepository;

  GetMessagesUseCase(this._chatRepository);

  Future<List<Message>> execute(int chatRoomId) {
    return _chatRepository.getMessagesByChatRoomId(chatRoomId);
  }
}
