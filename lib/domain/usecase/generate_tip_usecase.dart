import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/tip/tip_dto.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';

class GenerateTipUsecase {
  final AIRepository aiRepository = getIt<AIRepository>();

  Future<TipDto?> execute(Message message) async {
    return await aiRepository.getTip(message);
  }
}
