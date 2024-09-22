import 'package:get/get.dart';
import 'package:palink_v2/data/mapper/ai_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_request.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/ai_response/chat_request.dart';
import 'package:palink_v2/data/models/ai_response/chat_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/user/user.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/tip_viewmodel.dart';
import 'fetch_chat_history_usecase.dart';
import 'generate_tip_usecase.dart';
import 'get_user_info_usecase.dart';

class GenerateResponseUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();
  final GetUserInfoUseCase getUserInfoUseCase;
  final FetchChatHistoryUsecase fetchChatHistoryUsecase;
  final GenerateTipUsecase generateTipUsecase;

  GenerateResponseUsecase(this.getUserInfoUseCase, this.fetchChatHistoryUsecase, this.generateTipUsecase);

  Future<Map<String?, AIResponse?>> execute(int conversationId, Character character, String userMessage, List<String> unachievedQuests) async {

    User? user = await getUserInfoUseCase.execute();

    // 응답 생성
    AIMessageResponse? aimessageResponse = await aiRepository.getChatResponse(AIMessageRequest(
      persona: character.persona,
      userName: user!.name,
      userMessage: userMessage,
    ));

    MessageResponse? messageResponse;
    AIResponse? aiResponse;
    if (aimessageResponse != null) {
      // 호감도 분석 생성
      LikingResponse? likingResponse = await aiRepository.judgeSentiment(userMessage, aimessageResponse!.message);

      // 거절 점수 판정
      RejectionResponse? rejectionResponse = await aiRepository.judgeRejection(userMessage);

      // 매퍼를 통해 AIResponse로 변환
      aiResponse = aimessageResponse.toAIResponse(likingResponse!, rejectionResponse!, character);

      // 메시지 저장
      var messageRequest = aiResponse.toMessageRequest();
      messageResponse = await chatRepository.saveMessage(conversationId, messageRequest);

      // 팁 생성
      final tip = await generateTipUsecase.execute(aiResponse.text, unachievedQuests);

      final tipViewModel = Get.find<TipViewModel>();
      tip != null
          ? tipViewModel.updateTip(tip.answer)
          : tipViewModel.updateTip('팁 생성 전입니다!');
    }

    return {messageResponse?.messageId.toString(): aiResponse}; // Map 반환
  }
}
