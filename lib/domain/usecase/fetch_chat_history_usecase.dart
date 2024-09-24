import 'package:palink_v2/data/mapper/message_response_mapper.dart';
import 'package:palink_v2/data/models/chat/messages_response.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class FetchChatHistoryUsecase {
  final ChatRepository repository;

  FetchChatHistoryUsecase(this.repository);

  Future<List<Message>?> execute(int chatRoomId) async {
    try {
      final MessagesResponse? response =
          await repository.fetchMessagesByChatRoomId(chatRoomId);
      return response?.messages.map((msg) => msg.toDomain()).toList();
    } catch (e) {
      print('Error fetching chat history: $e');
      return null;
    }
  }
}
