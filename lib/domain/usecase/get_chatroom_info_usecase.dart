// domain/usecases/get_chatroom_info_usecase.dart
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';

class GetChatroomInfoUsecase {
  final ChatRepository chatRepository;

  GetChatroomInfoUsecase(this.chatRepository);

  Future<ConversationResponse> execute(int chatRoomId) async {
    return await chatRepository.fetchConversationByChatRoomId(chatRoomId);
  }
}
