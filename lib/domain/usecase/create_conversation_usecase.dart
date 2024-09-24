import 'package:palink_v2/data/models/chat/conversation_request.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/model/chat/conversation.dart';
import 'package:palink_v2/domain/model/user/user.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

import 'get_user_info_usecase.dart';

class CreateConversationUseCase {
  final ChatRepository chatRepository;
  final GetUserInfoUseCase getUserInfoUseCase;

  CreateConversationUseCase(this.chatRepository, this.getUserInfoUseCase);

  Future<Conversation?> execute(Character character) async {
    User? user = await getUserInfoUseCase.execute();
    var conversationRequest = ConversationRequest(
      day: DateTime.now().toIso8601String(),
      userId: user!.userId!,
      characterId: character.characterId,
    );
    ConversationResponse response =
        await chatRepository.createConversation(conversationRequest);
    return Conversation.fromResponse(response);
  }
}
