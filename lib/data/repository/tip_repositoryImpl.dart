import 'package:palink_v2/core/utils/message_utils.dart';
import 'package:palink_v2/data/api/chat/chat_api.dart';
import 'package:palink_v2/data/api/tip/tip_api.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/chat/ai_response_response.dart';
import 'package:palink_v2/data/models/chat/conversation_request.dart';
import 'package:palink_v2/data/models/chat/conversation_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/data/models/chat/message_response.dart';
import 'package:palink_v2/data/models/chat/messages_response.dart';
import 'package:palink_v2/data/models/tip/tip_create_request.dart';
import 'package:palink_v2/data/models/tip/tip_dto.dart';
import 'package:palink_v2/data/models/tip/tip_response.dart';
import 'package:palink_v2/domain/repository/chat_repository.dart';
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

