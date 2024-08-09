// data/database/app_database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:palink_v2/data/dao/character_dao.dart';
import 'package:palink_v2/data/dao/character_quest_dao.dart';
import 'package:palink_v2/data/dao/mindset_dao.dart';
import 'package:palink_v2/data/entities/character_entity.dart';
import 'package:palink_v2/data/entities/character_quest_entity.dart';
import 'package:palink_v2/data/entities/mindset_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [CharacterEntity, CharacterQuestEntity, MindsetEntity])
abstract class AppDatabase extends FloorDatabase {
  CharacterDao get characterDao;
  CharacterQuestDao get characterQuestDao;
  MindsetDao get mindsetDao;
}
