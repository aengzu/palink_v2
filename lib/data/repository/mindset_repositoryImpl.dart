import 'package:palink_v2/data/api/mindset/mindset_api.dart';
import 'package:palink_v2/data/models/mindset/mindset_response.dart';
import 'package:palink_v2/domain/model/mindset/mindset.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';

class MindsetRepositoryImpl implements MindsetRepository {
  final MindsetApi mindsetApi;

  MindsetRepositoryImpl(this.mindsetApi);

  @override
  Future<MindsetResponse?> getRandomMindset() async {
    return mindsetApi.getRandomMindset();
  }
}
