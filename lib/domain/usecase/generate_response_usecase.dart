import 'package:get/get.dart';
import 'package:palink_v2/data/mapper/ai_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_request.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/model/chat/message.dart';
import 'package:palink_v2/domain/model/user/user.dart';
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

  Future<Map<String?, dynamic>> execute(int conversationId, Character character, String userMessage, List<String> unachievedQuests) async {

    User? user = await getUserInfoUseCase.execute();


    // 채팅 기록을 가져옵니다.
    final chatHistoryResponse = await fetchChatHistoryUsecase.execute(conversationId);
    String chatHistory = _formatChatHistory(chatHistoryResponse!);

    // 응답 생성 요청에 포함할 메시지 기록
    AIMessageResponse? aiMessageResponse = await aiRepository.getChatResponse(AIMessageRequest(
      persona: character.persona,
      userName: user!.name,
      userMessage: userMessage,
      chatHistory: chatHistory, // 채팅 기록을 추가
    ));

    MessageResponse? messageResponse;
    AIResponse? aiResponse;
    if (aiMessageResponse != null) {
      // 호감도 분석 생성
      // LikingResponse? likingResponse = await aiRepository.judgeSentiment(userMessage, aiMessageResponse!.message);

      // 거절 점수 판정
      RejectionResponse? rejectionResponse = await aiRepository.judgeRejection(userMessage);

      // 매퍼를 통해 AIResponse로 변환
      aiResponse = aiMessageResponse.toAIResponse(rejectionResponse!, character);

      // 메시지 저장
      var messageRequest = aiResponse.toMessageRequest();
      messageResponse = await chatRepository.saveMessage(conversationId, messageRequest);
      List<AIResponseResponse> aiResponseResponse = await chatRepository.fetchAIResponseByMessageId(conversationId, messageResponse!.messageId);

      // AIResponseResponse에서 최종 점수 가져오기
      if (aiResponseResponse != null) {
        aiResponse.finalAffinityScore = aiResponseResponse[0].finalAffinityScore;
        aiResponse.finalRejectionScore = aiResponseResponse[0].finalRejectionScore;
      }

      // 팁 생성
      final tip = await generateTipUsecase.execute(messageResponse!.messageId, aiResponse.text, unachievedQuests);

      final tipViewModel = Get.find<TipViewModel>();
      tip != null
          ? tipViewModel.updateTip(tip.answer)
          : tipViewModel.updateTip('팁 생성 전입니다!');
    }

    // Map으로 AIResponse와 isEnd를 함께 반환
    return {
      "aiResponse": aiResponse,
      "messageId": messageResponse?.messageId,
      "isEnd": aiMessageResponse?.isEnd ?? false,  // isEnd가 null일 경우 false로 설정
    };
  }
  // chatHistoryResponse를 JSON 또는 텍스트로 변환하는 함수
  String _formatChatHistory(List<Message> chatHistoryResponse) {
    // 메시지를 순차적으로 텍스트로 변환
    return chatHistoryResponse.map((message) => "${message.sender}: ${message.messageText}").join("\n");
  }
}
