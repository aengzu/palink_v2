

import 'package:palink_v2/data/models/tip/tip_create_request.dart';
import 'package:palink_v2/data/models/tip/tip_response.dart';

abstract class TipRepository {
  Future<TipResponse> createTip(TipCreateRequest tipRequest);
  Future<TipResponse> readTip(int tipId);
  Future<List<TipResponse>> getTipsByMessageId(int messageId);
}
