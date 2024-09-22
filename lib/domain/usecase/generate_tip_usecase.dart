import 'package:palink_v2/data/models/ai_response/tip_request.dart';
import 'package:palink_v2/data/models/ai_response/tip_response.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';

class GenerateTipUsecase {
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();


  Future<TipResponse?> execute(String message, List<String> unachievedQuests) async {
    TipRequest input = TipRequest(
      message: message,
      unachievedQuests: unachievedQuests,
    );
    return await aiRepository.createTip(input);
  }
}
