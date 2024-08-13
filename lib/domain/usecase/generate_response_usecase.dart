import 'package:get/get.dart';
import 'package:palink_v2/data/mapper/ai_response_mapper.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
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

  Future<AIResponse?> execute(int conversationId, Character character) async {
    // 사용자 정보 가져오기
    User? user = await getUserInfoUseCase.execute();

    // 이전 대화 기록 페치
    final memoryVariables = await aiRepository.getMemory();
    final chatHistory = memoryVariables['history'] ?? '';

    // AI와의 대화 시작
    final inputs = {
      'input': '유저의 마지막 말에 대답하세요. 대화 맥락을 기억합니다.',
      'chat_history': chatHistory,
      'userName': user!.name,
      'description': character.prompt,
    };

    AIResponse? aiResponse = await aiRepository.processChat(inputs);

    // AI 응답을 메시지로 변환하여 저장
    if (aiResponse != null) {
      final messageRequest = aiResponse.toMessageRequest();
      await chatRepository.saveMessage(conversationId, messageRequest);

      await aiRepository.saveMemoryContext(inputs, {'response': aiResponse});

      final tip = await generateTipUsecase.execute(aiResponse.text);
      final tipViewModel = Get.find<TipViewModel>();
      tip != null
          ? tipViewModel.updateTip(tip.answer)
          : tipViewModel.updateTip('팁 생성 전입니다!');
    }

    return aiResponse;
  }
}
