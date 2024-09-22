// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CharacterDao? _characterDaoInstance;

  CharacterQuestDao? _characterQuestDaoInstance;

  MindsetDao? _mindsetDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `characters` (`characterId` INTEGER NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `requestStrength` INTEGER NOT NULL, `prompt` TEXT NOT NULL, `description` TEXT NOT NULL, `image` TEXT NOT NULL, `quest` TEXT NOT NULL, PRIMARY KEY (`characterId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `character_quests` (`characterId` INTEGER NOT NULL, `quests` TEXT NOT NULL, PRIMARY KEY (`characterId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `mindset` (`id` INTEGER NOT NULL, `group` INTEGER NOT NULL, `content` TEXT NOT NULL, `reason` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CharacterDao get characterDao {
    return _characterDaoInstance ??= _$CharacterDao(database, changeListener);
  }

  @override
  CharacterQuestDao get characterQuestDao {
    return _characterQuestDaoInstance ??=
        _$CharacterQuestDao(database, changeListener);
  }

  @override
  MindsetDao get mindsetDao {
    return _mindsetDaoInstance ??= _$MindsetDao(database, changeListener);
  }
}

class _$CharacterDao extends CharacterDao {
  _$CharacterDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _characterEntityInsertionAdapter = InsertionAdapter(
            database,
            'characters',
            (CharacterEntity item) => <String, Object?>{
                  'characterId': item.characterId,
                  'name': item.name,
                  'type': item.type,
                  'requestStrength': item.requestStrength,
                  'prompt': item.prompt,
                  'description': item.description,
                  'image': item.image,
                  'quest': item.quest
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CharacterEntity> _characterEntityInsertionAdapter;

  @override
  Future<List<CharacterEntity>> getAllCharacters() async {
    return _queryAdapter.queryList('SELECT * FROM characters',
        mapper: (Map<String, Object?> row) => CharacterEntity(
            characterId: row['characterId'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            requestStrength: row['requestStrength'] as int,
            prompt: row['prompt'] as String,
            description: row['description'] as String,
            image: row['image'] as String,
            quest: row['quest'] as String));
  }

  @override
  Future<CharacterEntity?> getCharacterById(int characterId) async {
    return _queryAdapter.query(
        'SELECT * FROM characters WHERE characterId = ?1',
        mapper: (Map<String, Object?> row) => CharacterEntity(
            characterId: row['characterId'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            requestStrength: row['requestStrength'] as int,
            prompt: row['prompt'] as String,
            description: row['description'] as String,
            image: row['image'] as String,
            quest: row['quest'] as String),
        arguments: [characterId]);
  }

  @override
  Future<void> insertCharacter(CharacterEntity character) async {
    await _characterEntityInsertionAdapter.insert(
        character, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertCharacters(List<CharacterEntity> characters) async {
    await _characterEntityInsertionAdapter.insertList(
        characters, OnConflictStrategy.replace);
  }
}

class _$CharacterQuestDao extends CharacterQuestDao {
  _$CharacterQuestDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<CharacterQuestEntity>> getAllCharacterQuests() async {
    return _queryAdapter.queryList('SELECT * FROM character_quests',
        mapper: (Map<String, Object?> row) => CharacterQuestEntity(
            characterId: row['characterId'] as int,
            quests: row['quests'] as String));
  }

  @override
  Future<CharacterQuestEntity?> getCharacterQuestsById(int characterId) async {
    return _queryAdapter.query(
        'SELECT * FROM character_quests WHERE characterId = ?1',
        mapper: (Map<String, Object?> row) => CharacterQuestEntity(
            characterId: row['characterId'] as int,
            quests: row['quests'] as String),
        arguments: [characterId]);
  }
}

class _$MindsetDao extends MindsetDao {
  _$MindsetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mindsetEntityInsertionAdapter = InsertionAdapter(
            database,
            'mindset',
            (MindsetEntity item) => <String, Object?>{
                  'id': item.id,
                  'group': item.group,
                  'content': item.content,
                  'reason': item.reason
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MindsetEntity> _mindsetEntityInsertionAdapter;

  @override
  Future<MindsetEntity?> getRandomMindset() async {
    return _queryAdapter.query(
        'SELECT * FROM mindset ORDER BY RANDOM() LIMIT 1',
        mapper: (Map<String, Object?> row) => MindsetEntity(
            id: row['id'] as int,
            group: row['group'] as int,
            content: row['content'] as String,
            reason: row['reason'] as String));
  }

  @override
  Future<MindsetEntity?> getRandomMindsetByGroup(String group) async {
    return _queryAdapter.query(
        'SELECT * FROM mindset WHERE group = ?1 ORDER BY RANDOM() LIMIT 1',
        mapper: (Map<String, Object?> row) => MindsetEntity(
            id: row['id'] as int,
            group: row['group'] as int,
            content: row['content'] as String,
            reason: row['reason'] as String),
        arguments: [group]);
  }

  @override
  Future<List<MindsetEntity>> getAllMindsets() async {
    return _queryAdapter.queryList('SELECT * FROM mindset',
        mapper: (Map<String, Object?> row) => MindsetEntity(
            id: row['id'] as int,
            group: row['group'] as int,
            content: row['content'] as String,
            reason: row['reason'] as String));
  }

  @override
  Future<void> insertMindsets(List<MindsetEntity> mindsets) async {
    await _mindsetEntityInsertionAdapter.insertList(
        mindsets, OnConflictStrategy.replace);
  }
}
