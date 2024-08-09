import 'package:palink_v2/data/entities/mindset_entity.dart';
import 'package:palink_v2/domain/models/mindset/mindset.dart';

class MindsetMapper {
  static Mindset fromEntity(MindsetEntity entity) {
    return Mindset(
      content: entity.content,
      reason: entity.reason,
    );
  }
}
