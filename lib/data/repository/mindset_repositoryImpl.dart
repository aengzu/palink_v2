
import 'package:palink_v2/data/dao/mindset_dao.dart';
import 'package:palink_v2/data/mapper/mindset_mappder.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/domain/entities/mindset/mindset.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';


class MindsetRepositoryImpl implements MindsetRepository {
  final MindsetDao mindsetDao = getIt<MindsetDao>();

  MindsetRepositoryImpl();

  @override
  Future<Mindset?> getRandomMindset() async {
    final entity = await mindsetDao.getRandomMindset();
    return MindsetMapper.fromEntity(entity!);
  }

}
