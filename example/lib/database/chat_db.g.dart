// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  UserDao? _userDaoInstance;

  RoomDao? _roomDaoInstance;

  MessageDao? _messageDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `User` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `clientId` TEXT NOT NULL, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `avatar` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Room` (`id` TEXT NOT NULL, `otherMemberId` TEXT, `name` TEXT NOT NULL, `avatar` TEXT, `isGroup` INTEGER NOT NULL, `presence` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Message` (`id` TEXT NOT NULL, `type` TEXT NOT NULL, `fromId` TEXT, `fromName` TEXT, `toId` TEXT, `toName` TEXT, `text` TEXT NOT NULL, `roomId` TEXT NOT NULL, `originality` TEXT NOT NULL, `attachment` TEXT, `thumbnail` TEXT, `originalId` TEXT, `originalMessage` TEXT, `size` INTEGER, `mime` TEXT, `longitude` REAL, `latitude` REAL, `sendTime` INTEGER NOT NULL, `status` TEXT, PRIMARY KEY (`id`))');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `RecentChat` AS SELECT m.id lastMessageId, m.type as lastMessageType, m.fromId lastMessageFromId, m.text lastMessageText, m.fromName lastMessageFromName, m.status lastMessageStatus, m.roomId roomId, r.name name, r.avatar avatar, r.isGroup isGroup  FROM message m  JOIN room r ON r.id  = m.roomId JOIN (SELECT MAX(sendTime) maxtime, fromId, roomId from message group by roomId) latest on m.sendTime = latest.maxtime and m.roomId = latest.roomId ');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  RoomDao get roomDao {
    return _roomDaoInstance ??= _$RoomDao(database, changeListener);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'clientId': item.clientId,
                  'username': item.username,
                  'password': item.password,
                  'avatar': item.avatar
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as String,
            name: row['name'] as String,
            clientId: row['clientId'] as String,
            username: row['username'] as String,
            password: row['password'] as String,
            avatar: row['avatar'] as String?));
  }

  @override
  Stream<List<User>> findAllUsersAsync() {
    return _queryAdapter.queryListStream('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as String,
            name: row['name'] as String,
            clientId: row['clientId'] as String,
            username: row['username'] as String,
            password: row['password'] as String,
            avatar: row['avatar'] as String?),
        queryableName: 'User',
        isView: false);
  }

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM User');
  }

  @override
  Future<void> insertUserInternal(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertUser(User user) async {
    if (database is sqflite.Transaction) {
      await super.insertUser(user);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.userDao.insertUser(user);
      });
    }
  }
}

class _$RoomDao extends RoomDao {
  _$RoomDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _roomInsertionAdapter = InsertionAdapter(
            database,
            'Room',
            (Room item) => <String, Object?>{
                  'id': item.id,
                  'otherMemberId': item.otherMemberId,
                  'name': item.name,
                  'avatar': item.avatar,
                  'isGroup': item.isGroup ? 1 : 0,
                  'presence': _presenceTypeConverter.encode(item.presence)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Room> _roomInsertionAdapter;

  @override
  Stream<List<Room>> findAllRoomsAsync() {
    return _queryAdapter.queryListStream('SELECT * FROM Room',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as String,
            otherMemberId: row['otherMemberId'] as String?,
            name: row['name'] as String,
            avatar: row['avatar'] as String?,
            isGroup: (row['isGroup'] as int) != 0,
            presence:
                _presenceTypeConverter.decode(row['presence'] as String?)),
        queryableName: 'Room',
        isView: false);
  }

  @override
  Stream<List<Room>> findPrivateRoomsAsync() {
    return _queryAdapter.queryListStream('SELECT * FROM Room WHERE isGroup = 0',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as String,
            otherMemberId: row['otherMemberId'] as String?,
            name: row['name'] as String,
            avatar: row['avatar'] as String?,
            isGroup: (row['isGroup'] as int) != 0,
            presence:
                _presenceTypeConverter.decode(row['presence'] as String?)),
        queryableName: 'Room',
        isView: false);
  }

  @override
  Stream<List<Room>> findGroupRoomsAsync() {
    return _queryAdapter.queryListStream('SELECT * FROM Room WHERE isGroup = 1',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as String,
            otherMemberId: row['otherMemberId'] as String?,
            name: row['name'] as String,
            avatar: row['avatar'] as String?,
            isGroup: (row['isGroup'] as int) != 0,
            presence:
                _presenceTypeConverter.decode(row['presence'] as String?)),
        queryableName: 'Room',
        isView: false);
  }

  @override
  Future<void> updateRoomPresence(String userId, PresenceType presence) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Room SET presence = ?2 WHERE otherMemberId = ?1',
        arguments: [userId, _presenceNotNullTypeConverter.encode(presence)]);
  }

  @override
  Future<void> deleteAllRooms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Room');
  }

  @override
  Future<void> insertRooms(List<Room> rooms) async {
    await _roomInsertionAdapter.insertList(rooms, OnConflictStrategy.replace);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _messageInsertionAdapter = InsertionAdapter(
            database,
            'Message',
            (Message item) => <String, Object?>{
                  'id': item.id,
                  'type': _messageTypeConverter.encode(item.type),
                  'fromId': item.fromId,
                  'fromName': item.fromName,
                  'toId': item.toId,
                  'toName': item.toName,
                  'text': item.text,
                  'roomId': item.roomId,
                  'originality':
                      _messageOriginalityConverter.encode(item.originality),
                  'attachment': item.attachment,
                  'thumbnail': item.thumbnail,
                  'originalId': item.originalId,
                  'originalMessage': item.originalMessage,
                  'size': item.size,
                  'mime': item.mime,
                  'longitude': item.longitude,
                  'latitude': item.latitude,
                  'sendTime': _dateTimeConverter.encode(item.sendTime),
                  'status': _chatMarkerConverter.encode(item.status)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Message> _messageInsertionAdapter;

  @override
  Stream<List<Message>> allMessages() {
    return _queryAdapter.queryListStream('SELECT * FROM Message',
        mapper: (Map<String, Object?> row) => Message(
            id: row['id'] as String,
            type: _messageTypeConverter.decode(row['type'] as String),
            fromId: row['fromId'] as String?,
            fromName: row['fromName'] as String?,
            toId: row['toId'] as String?,
            toName: row['toName'] as String?,
            text: row['text'] as String,
            roomId: row['roomId'] as String,
            originality: _messageOriginalityConverter
                .decode(row['originality'] as String),
            attachment: row['attachment'] as String?,
            thumbnail: row['thumbnail'] as String?,
            originalId: row['originalId'] as String?,
            originalMessage: row['originalMessage'] as String?,
            size: row['size'] as int?,
            mime: row['mime'] as String?,
            longitude: row['longitude'] as double?,
            latitude: row['latitude'] as double?,
            sendTime: _dateTimeConverter.decode(row['sendTime'] as int),
            status: _chatMarkerConverter.decode(row['status'] as String?)),
        queryableName: 'Message',
        isView: false);
  }

  @override
  Stream<List<RecentChat>> getRecentChats() {
    return _queryAdapter.queryListStream('SELECT * from recentChat',
        mapper: (Map<String, Object?> row) => RecentChat(
            roomId: row['roomId'] as String,
            name: row['name'] as String,
            avatar: row['avatar'] as String?,
            isGroup: (row['isGroup'] as int) != 0,
            lastMessageId: row['lastMessageId'] as String,
            lastMessageType:
                _messageTypeConverter.decode(row['lastMessageType'] as String),
            lastMessageText: row['lastMessageText'] as String,
            lastMessageFromId: row['lastMessageFromId'] as String,
            lastMessageFromName: row['lastMessageFromName'] as String?,
            lastMessageStatus: _chatMarkerConverter
                .decode(row['lastMessageStatus'] as String?)),
        queryableName: 'RecentChat',
        isView: true);
  }

  @override
  Stream<List<Message>> allMessagesByRoomId(String roomId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Message WHERE roomId = ?1',
        mapper: (Map<String, Object?> row) => Message(
            id: row['id'] as String,
            type: _messageTypeConverter.decode(row['type'] as String),
            fromId: row['fromId'] as String?,
            fromName: row['fromName'] as String?,
            toId: row['toId'] as String?,
            toName: row['toName'] as String?,
            text: row['text'] as String,
            roomId: row['roomId'] as String,
            originality: _messageOriginalityConverter
                .decode(row['originality'] as String),
            attachment: row['attachment'] as String?,
            thumbnail: row['thumbnail'] as String?,
            originalId: row['originalId'] as String?,
            originalMessage: row['originalMessage'] as String?,
            size: row['size'] as int?,
            mime: row['mime'] as String?,
            longitude: row['longitude'] as double?,
            latitude: row['latitude'] as double?,
            sendTime: _dateTimeConverter.decode(row['sendTime'] as int),
            status: _chatMarkerConverter.decode(row['status'] as String?)),
        arguments: [roomId],
        queryableName: 'Message',
        isView: false);
  }

  @override
  Future<List<Message>> getUnsentMessages() async {
    return _queryAdapter.queryList('SELECT * FROM Message WHERE status is null',
        mapper: (Map<String, Object?> row) => Message(
            id: row['id'] as String,
            type: _messageTypeConverter.decode(row['type'] as String),
            fromId: row['fromId'] as String?,
            fromName: row['fromName'] as String?,
            toId: row['toId'] as String?,
            toName: row['toName'] as String?,
            text: row['text'] as String,
            roomId: row['roomId'] as String,
            originality: _messageOriginalityConverter
                .decode(row['originality'] as String),
            attachment: row['attachment'] as String?,
            thumbnail: row['thumbnail'] as String?,
            originalId: row['originalId'] as String?,
            originalMessage: row['originalMessage'] as String?,
            size: row['size'] as int?,
            mime: row['mime'] as String?,
            longitude: row['longitude'] as double?,
            latitude: row['latitude'] as double?,
            sendTime: _dateTimeConverter.decode(row['sendTime'] as int),
            status: _chatMarkerConverter.decode(row['status'] as String?)));
  }

  @override
  Future<void> updateMessageStatus(String chatMarker, String messageId) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Message SET status = ?1 WHERE id = ?2',
        arguments: [chatMarker, messageId]);
  }

  @override
  Future<void> deleteAllMessages() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Message');
  }

  @override
  Future<void> deleteAllMessagesByRoomId(String roomId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Message WHERE roomId = ?1',
        arguments: [roomId]);
  }

  @override
  Future<void> insertMessages(List<Message> messages) async {
    await _messageInsertionAdapter.insertList(
        messages, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertMessage(Message message) async {
    await _messageInsertionAdapter.insert(message, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _messageTypeConverter = MessageTypeConverter();
final _messageOriginalityConverter = MessageOriginalityConverter();
final _chatMarkerConverter = ChatMarkerConverter();
final _presenceTypeConverter = PresenceTypeConverter();
final _presenceNotNullTypeConverter = PresenceNotNullTypeConverter();
