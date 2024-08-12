

import 'package:palink_v2/domain/entities/mindset/mindset.dart';

abstract class MindsetRepository {
  Future<Mindset?> getRandomMindset();
}
