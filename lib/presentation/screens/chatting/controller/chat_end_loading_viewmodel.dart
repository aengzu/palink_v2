import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/models/analysis_dto/analysis_dto.dart';
import 'package:palink_v2/domain/models/character/character.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/mindset/mindset.dart';
import 'package:palink_v2/domain/usecase/generate_analyze_usecase.dart';
import 'package:palink_v2/domain/usecase/get_random_mindset_usecase.dart';
import 'package:palink_v2/presentation/screens/feedback/controller/feedback_viewmodel.dart';
import 'package:palink_v2/presentation/screens/feedback/view/feedback_view.dart';


class ChatEndLoadingViewModel extends GetxController {
  final GetRandomMindsetUseCase getRandomMindsetUseCase = getIt<GetRandomMindsetUseCase>();
  final GenerateAnalyzeUsecase generateAnalyzeUsecase = getIt<GenerateAnalyzeUsecase>();
  final Character character;
  final List<Message> chatHistory;

  Mindset? randomMindset;
  bool isLoading = true;

  ChatEndLoadingViewModel({required this.character, required this.chatHistory}) {
    _loadMindset();
    _analyzeConversation(character);
  }

  Future<void> _loadMindset() async {
    randomMindset = await getRandomMindsetUseCase.execute();
    isLoading = false;
  }


  Future<void> _analyzeConversation(Character character) async {
    try {
     AnalysisDto? analysisDto = await generateAnalyzeUsecase.execute(character, chatHistory);
     if (analysisDto == null) {
       print('Failed to analyze conversation: analysisDto is null');
       return;
     }
     else {
       Get.off(() => FeedbackView(viewModel: Get.put(FeedbackViewmodel(analysisDto: analysisDto!, character: character))));
     }
    } catch (e) {
      print('Failed to analyze conversation: $e');
    }
  }

}
