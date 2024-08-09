import 'package:floor/floor.dart';
import 'package:palink_v2/data/entities/mindset_entity.dart';


@dao
abstract class MindsetDao {
  @Query('SELECT * FROM mindset ORDER BY RANDOM() LIMIT 1')
  Future<MindsetEntity?> getRandomMindset();

  @Query('SELECT * FROM mindset WHERE group = :group ORDER BY RANDOM() LIMIT 1')
  Future<MindsetEntity?> getRandomMindsetByGroup(String group);

  @Query('SELECT * FROM mindset')
  Future<List<MindsetEntity>> getAllMindsets();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMindsets(List<MindsetEntity> mindsets);
}
