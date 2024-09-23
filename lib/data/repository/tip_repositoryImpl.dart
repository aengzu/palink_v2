
import 'package:palink_v2/data/api/tip/tip_api.dart';
import 'package:palink_v2/data/models/tip/tip_create_request.dart';
import 'package:palink_v2/data/models/tip/tip_response.dart';
import 'package:palink_v2/domain/repository/tip_repository.dart';


class TipRepositoryImpl implements TipRepository {
  final TipApi tipApi;

  TipRepositoryImpl(this.tipApi);

  @override
  Future<TipResponse> createTip(TipCreateRequest tipRequest) {
    return tipApi.saveTip(tipRequest);
  }

  @override
  Future<List<TipResponse>> getTipsByMessageId(int messageId) {
    return tipApi.getTipsByMessageId(messageId);
  }

  @override
  Future<TipResponse> readTip(int tipId) {
    return tipApi.getTipById(tipId);
  }

}

