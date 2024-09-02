import 'package:get/get.dart';
import 'package:palink_v2/data/mapper/ai_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
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


  Future<Map<String, dynamic>?> execute(int conversationId, String userName, String description) async {
    final inputs = {
      'input': '당신이 먼저 부탁을 하며 대화를 시작하세요.',
      'chat_history': [],
      'userName': userName,
      'description': description,
      'rejection_score_rule' : 'default',
    };

    AIResponse? aiResponse = await aiRepository.processChat(inputs);


    if (aiResponse != null) {
      var messageRequest = aiResponse.toMessageRequest();
      await chatRepository.saveMessage(conversationId, messageRequest);
      await aiRepository.saveMemoryContext(inputs, {'response': aiResponse});
      // 팁 생성
      final tip = await generateTipUsecase.execute(aiResponse.text);

      // AI 응답과 팁을 함께 반환
      return {
        'aiResponse': aiResponse,
        'tip': tip?.answer ?? '기본 팁이 없습니다.',
      };
  }
}
}
