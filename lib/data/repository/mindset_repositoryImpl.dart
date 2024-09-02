

import 'package:palink_v2/data/api/mindset/mindset_api.dart';
import 'package:palink_v2/domain/entities/mindset/mindset.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';


class MindsetRepositoryImpl implements MindsetRepository {
  final MindsetApi mindsetApi;

  MindsetRepositoryImpl(this.mindsetApi);

  @override
  Future<Mindset?> getRandomMindset() async {
    Mindset mindset = mindsetApi.getRandomMindset() as Mindset;
    return mindset;
  }

}
