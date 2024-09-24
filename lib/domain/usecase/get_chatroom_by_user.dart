import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';

class GetChatroomByUser {
  final ChatRepository chatRepository;
  final UserRepository userRepository;

  GetChatroomByUser(this.chatRepository, this.userRepository);

  Future<List<ConversationResponse>> execute() async {
    int? userId = userRepository.getUserId();
    return await chatRepository.fetchConversationsByUserId(userId!);
  }
}
