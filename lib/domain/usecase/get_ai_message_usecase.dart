// domain/usecases/get_chatroom_info_usecase.dart
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class GetChatroomInfoUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();

  GetChatroomInfoUsecase();

  Future<AIResponseResponse> execute(int conversationId, int messageId) async {
    return await chatRepository.fetchAIResponseByMessageId(conversationId, messageId);
  }
}
