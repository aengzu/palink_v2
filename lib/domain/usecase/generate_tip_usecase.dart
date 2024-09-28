import 'package:palink_v2/data/models/ai_response/tip_request.dart';
import 'package:palink_v2/data/models/ai_response/tip_response.dart';
import 'package:palink_v2/data/models/tip/tip_create_request.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/model/tip/tip.dart';
import 'package:palink_v2/domain/repository/open_ai_repository.dart';
import 'package:palink_v2/domain/repository/tip_repository.dart';

class GenerateTipUsecase {
  final OpenAIRepository aiRepository = getIt<OpenAIRepository>();
  final TipRepository tipRepository = getIt<TipRepository>();

  Future<TipResponse?> execute(
      int messageId, String message, List<String> unachievedQuests) async {
    TipRequest input = TipRequest(
      message: message,
      unachievedQuests: unachievedQuests,
    );

    TipResponse? tipResponse = await aiRepository.createTip(input);
    TipResponse? newTipResponse;
    if (tipResponse != null) {
      // answer와 reason을 결합하여 하나의 문자열로 만들기
      String combinedTipText =
          '${tipResponse.answer}';
      // TipRepository를 통해 팁 저장
      tipRepository.createTip(
        TipCreateRequest(
          messageId: messageId,
          tipText: combinedTipText, // 결합된 문자열을 전달
        ),
      );
      newTipResponse = TipResponse(
        answer: combinedTipText,
        reason: combinedTipText,
      );
    }
    return newTipResponse;
  }
}
