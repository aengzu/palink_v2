

import 'package:palink_v2/data/models/mindset/mindset_response.dart';


abstract class MindsetRepository {
  Future<MindsetResponse?> getRandomMindset();
}
