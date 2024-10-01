import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/analysis/analysis_dto.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/domain/usecase/generate_analyze_usecase.dart';
import 'package:palink_v2/domain/usecase/get_ai_messages_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/domain/usecase/save_feedback_usecase.dart';
import 'package:palink_v2/presentation/screens/feedback/controller/feedback_viewmodel.dart';
import 'package:palink_v2/presentation/screens/feedback/view/feedback_view.dart';

class ChatEndLoadingViewModel extends GetxController {
  final GetRandomMindsetUseCase getRandomMindsetUseCase =
      getIt<GetRandomMindsetUseCase>();
  final GenerateAnalyzeUsecase generateAnalyzeUsecase =
      getIt<GenerateAnalyzeUsecase>();
  final GetAIMessagesUsecase getAIMessagesUsecase =
      getIt<GetAIMessagesUsecase>();
  final SaveFeedbackUseCase saveFeedbackUseCase =
      getIt<SaveFeedbackUseCase>(); // Add the feedback use case

  final Character character;

  bool isLoading = true;

  final mindset;
  final conversationId; // 채팅방 아이디
  final finalRejectionScore; // 최종 거절 점수
  final finalAffinityScore; // 최종 호감도 점수
  final unachievedQuests; // 달성하지 못한 퀘스트 리스트

  ChatEndLoadingViewModel({
    required this.mindset,
    required this.conversationId,
    required this.character,
    required this.finalRejectionScore,
    required this.finalAffinityScore,
    required this.unachievedQuests,
  }) {
    _analyzeConversation(character);
  }

  Future<void> _analyzeConversation(Character character) async {
    try {
      List<AIResponseResponse> chatHistory =
          await getAIMessagesUsecase.execute(conversationId);
      // chatHistory 내의 각 AIResponseResponse 객체를 적절히 변환하여 하나의 문자열로 만듭니다.
      final String chatHistoryString = chatHistory.map((response) {
        // JSArray<String>을 List<String>로 변환
        final List<String> rejectionContent =
            List<String>.from(response.rejectionContent);
        return '''
      [User Message: ${response.userMessage},
      AIResponse: ${response.text},
      AIFeeling: ${response.feeling},
      User's RejectionScore: ${response.rejectionScore.join(', ')},
      User's used Rejection Content: ${rejectionContent.join(', ')}]
      ''';
      }).join('\n');
      // 미달성 퀘스트 리스트를 쉼표로 구분된 문자열로 변환
      final String unachievedQuestsString = unachievedQuests.join(', ');

      AnalysisResponse? response = await generateAnalyzeUsecase.execute(
          chatHistoryString, character.description!, finalRejectionScore);
      AnalysisDto? analysisDto = AnalysisDto(
        finalRejectionScore: finalRejectionScore,
        finalAffinityScore: finalAffinityScore,
        unachievedQuests: unachievedQuestsString,
        evaluation: response!.evaluation,
        usedRejection: response.usedRejection, type: response.type,
      );
      if (analysisDto == null) {
        return;
      } else {
        await saveFeedbackUseCase.execute(
          conversationId: conversationId,
          feedbackText: response.evaluation,
          // Use evaluation text
          finalLikingLevel: finalAffinityScore + 50,
          // Adjust liking score calculation
          totalRejectionScore:
              finalRejectionScore, // Pass final rejection score
        );

        Get.off(() => FeedbackView(
            viewModel: Get.put(FeedbackViewmodel(
                analysisDto: analysisDto, character: character))));
      }
    } catch (e) {
      print('Failed to analyze conversation: $e');
    }
  }
}
