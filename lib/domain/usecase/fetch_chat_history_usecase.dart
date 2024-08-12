import 'package:palink_v2/data/models/message_response.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/mapper/message_mapper.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class FetchChatHistoryUsecase {
  final ChatRepository repository;

  FetchChatHistoryUsecase(this.repository);

  Future<List<Message>> execute(int chatRoomId) async {
    List<MessageResponse> messageResponses = await repository.fetchMessagesByChatRoomId(chatRoomId);
    return messageResponses.map((response) => MessageMapper.toDomain(response)).toList();
  }
}
