import 'package:palink_v2/data/models/message_request.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/tip/tip.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';

class GenerateTipUsecase {
  final AIRepository aiRepository = getIt<AIRepository>();

  Future<TipDto?> execute(String message) async {
    return await aiRepository.getTip(message);
  }
}
