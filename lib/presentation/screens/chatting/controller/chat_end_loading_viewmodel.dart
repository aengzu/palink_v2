import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/data/models/mindset/mindset_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/analysis/analysis_dto.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/entities/mindset/mindset.dart';
import 'package:palink_v2/domain/usecase/generate_analyze_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/presentation/screens/feedback/controller/feedback_viewmodel.dart';
import 'package:palink_v2/presentation/screens/feedback/view/feedback_view.dart';


class ChatEndLoadingViewModel extends GetxController {
  final GetRandomMindsetUseCase getRandomMindsetUseCase = getIt<GetRandomMindsetUseCase>();
  final GenerateAnalyzeUsecase generateAnalyzeUsecase = getIt<GenerateAnalyzeUsecase>();
  final Character character;
  final List<Message> chatHistory;

  var randomMindset = MindsetResponse(mindsetText: '', mindsetId: 0).obs;
  bool isLoading = true;

  ChatEndLoadingViewModel({required this.character, required this.chatHistory}) {
    _loadMindset();
    _analyzeConversation(character);
  }

  Future<void> _loadMindset() async {
    var fetchedMindset = await getRandomMindsetUseCase.execute();
    randomMindset.value = fetchedMindset!;
    isLoading = false;
  }


  Future<void> _analyzeConversation(Character character) async {
    try {
     AnalysisResponse? response = await generateAnalyzeUsecase.execute(chatHistory);
      AnalysisDto? analysisDto = AnalysisDto(evaluation: response!.evaluation, usedRejection: '', finalRejectionScore: 4);
     if (analysisDto == null) {
       print('Failed to analyze conversation: analysisDto is null');
       return;
     }
     else {
       Get.off(() => FeedbackView(viewModel: Get.put(FeedbackViewmodel(analysisDto: analysisDto, character: character))));
     }
    } catch (e) {
      print('Failed to analyze conversation: $e');
    }
  }

}
