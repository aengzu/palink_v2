
import 'package:palink_v2/data/mapper/ai_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_request.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
import 'generate_tip_usecase.dart';

// 초기 AI 메시지를 생성하는 유스케이스
class GenerateInitialMessageUsecase {
  final ChatRepository chatRepository = getIt<ChatRepository>();
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();
  final GenerateTipUsecase generateTipUsecase;


  GenerateInitialMessageUsecase(this.generateTipUsecase);


  Future<Map<String, dynamic>?> execute(int conversationId, String userName, String persona, List<String> unachievedQuests) async {
    String userMessage =  '당신이 먼저 부탁을 하며 대화를 시작하세요.';
    userMessage = cleanString(userMessage);  // 특수문자 제거
    // 응답 생성
    AIMessageResponse? aiMessageResponse = await aiRepository.getChatResponse(AIMessageRequest(
      persona: persona,
      userName: userName,
      userMessage: userMessage,
      chatHistory: '', // 채팅 기록을 추가
    ));

    MessageResponse? messageResponse;
    AIResponse? aiResponse;
    if (aiMessageResponse != null) {
      // 호감도 분석 삭제
      // LikingResponse? likingResponse = await aiRepository.judgeSentiment(userMessage, aiMessageResponse!.message);

      // 매퍼를 통해 AIResponse로 변환
      aiResponse = aiMessageResponse.toInitialAIResponse();

      // 메시지 저장
      var messageRequest = aiResponse.toInitialMessageRequest();

      messageResponse = await chatRepository.saveMessage(conversationId, messageRequest);

      // 팁 생성
      final tip = await generateTipUsecase.execute(messageResponse!.messageId, aiResponse.text, unachievedQuests);

      // AI 응답과 팁을 함께 반환
      return {
        'aiResponse': aiResponse,
        "messageId": messageResponse?.messageId.toString(),
        'tip': tip?.answer ?? '기본 팁이 없습니다.',
        'isEnd' : aiMessageResponse.isEnd ?? false,
      };
    }
  }
  String cleanString(String input) {
    // 공백이나 특수문자를 제거합니다.
    return input.replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), '').trim();
  }
}
