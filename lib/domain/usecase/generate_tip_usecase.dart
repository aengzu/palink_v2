import 'package:palink_v2/data/models/tip/tip_dto.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';

class GenerateTipUsecase {
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();

  Future<TipDto?> execute(String message) async {
    return await aiRepository.createTip(message);
  }
}
