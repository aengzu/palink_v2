import 'package:flutter/cupertino.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';

class GetAIMessagesUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();

  GetAIMessagesUsecase();

  Future<List<AIResponseResponse>> execute(int conversationId) async {
    debugPrint('GetAIMessagesUsecase: execute');
    return await chatRepository.fetchAIResponsesByConversationId(conversationId);
  }
}
