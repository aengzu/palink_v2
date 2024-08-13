import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/analysis/analysis_dto.dart';
import 'package:palink_v2/domain/entities/character/character.dart';
import 'package:palink_v2/domain/entities/chat/message.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';

class GenerateAnalyzeUsecase {
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();

  Future<AnalysisDto?> execute(Character character, List<Message> chatHistory) {
    String input = '[캐릭터 설명] ${character.description}\n [거절 점수표] ${character.anaylzePrompt}  \n[채팅 히스토리] $chatHistory';
    return aiRepository.analyzeResponse(input);
  }
}
