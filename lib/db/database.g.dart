// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DbContact extends DataClass implements Insertable<DbContact> {
  final String id;
  final String lastName;
  final String firstName;
  final String roomId;
  final String? avatar;
  final bool isGroup;
  final String? presence;
  DbContact(
      {required this.id,
      required this.lastName,
      required this.firstName,
      required this.roomId,
      this.avatar,
      required this.isGroup,
      this.presence});
  factory DbContact.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbContact(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      roomId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}room_id'])!,
      avatar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      isGroup: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_group'])!,
      presence: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}presence']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['last_name'] = Variable<String>(lastName);
    map['first_name'] = Variable<String>(firstName);
    map['room_id'] = Variable<String>(roomId);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String?>(avatar);
    }
    map['is_group'] = Variable<bool>(isGroup);
    if (!nullToAbsent || presence != null) {
      map['presence'] = Variable<String?>(presence);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      lastName: Value(lastName),
      firstName: Value(firstName),
      roomId: Value(roomId),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      isGroup: Value(isGroup),
      presence: presence == null && nullToAbsent
          ? const Value.absent()
          : Value(presence),
    );
  }

  factory DbContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DbContact(
      id: serializer.fromJson<String>(json['id']),
      lastName: serializer.fromJson<String>(json['lastName']),
      firstName: serializer.fromJson<String>(json['firstName']),
      roomId: serializer.fromJson<String>(json['roomId']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      isGroup: serializer.fromJson<bool>(json['isGroup']),
      presence: serializer.fromJson<String?>(json['presence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastName': serializer.toJson<String>(lastName),
      'firstName': serializer.toJson<String>(firstName),
      'roomId': serializer.toJson<String>(roomId),
      'avatar': serializer.toJson<String?>(avatar),
      'isGroup': serializer.toJson<bool>(isGroup),
      'presence': serializer.toJson<String?>(presence),
    };
  }

  DbContact copyWith(
          {String? id,
          String? lastName,
          String? firstName,
          String? roomId,
          String? avatar,
          bool? isGroup,
          String? presence}) =>
      DbContact(
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        firstName: firstName ?? this.firstName,
        roomId: roomId ?? this.roomId,
        avatar: avatar ?? this.avatar,
        isGroup: isGroup ?? this.isGroup,
        presence: presence ?? this.presence,
      );
  @override
  String toString() {
    return (StringBuffer('DbContact(')
          ..write('id: $id, ')
          ..write('lastName: $lastName, ')
          ..write('firstName: $firstName, ')
          ..write('roomId: $roomId, ')
          ..write('avatar: $avatar, ')
          ..write('isGroup: $isGroup, ')
          ..write('presence: $presence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          lastName.hashCode,
          $mrjc(
              firstName.hashCode,
              $mrjc(
                  roomId.hashCode,
                  $mrjc(avatar.hashCode,
                      $mrjc(isGroup.hashCode, presence.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbContact &&
          other.id == this.id &&
          other.lastName == this.lastName &&
          other.firstName == this.firstName &&
          other.roomId == this.roomId &&
          other.avatar == this.avatar &&
          other.isGroup == this.isGroup &&
          other.presence == this.presence);
}

class ContactsCompanion extends UpdateCompanion<DbContact> {
  final Value<String> id;
  final Value<String> lastName;
  final Value<String> firstName;
  final Value<String> roomId;
  final Value<String?> avatar;
  final Value<bool> isGroup;
  final Value<String?> presence;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.lastName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.roomId = const Value.absent(),
    this.avatar = const Value.absent(),
    this.isGroup = const Value.absent(),
    this.presence = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String id,
    required String lastName,
    required String firstName,
    required String roomId,
    this.avatar = const Value.absent(),
    required bool isGroup,
    this.presence = const Value.absent(),
  })  : id = Value(id),
        lastName = Value(lastName),
        firstName = Value(firstName),
        roomId = Value(roomId),
        isGroup = Value(isGroup);
  static Insertable<DbContact> custom({
    Expression<String>? id,
    Expression<String>? lastName,
    Expression<String>? firstName,
    Expression<String>? roomId,
    Expression<String?>? avatar,
    Expression<bool>? isGroup,
    Expression<String?>? presence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastName != null) 'last_name': lastName,
      if (firstName != null) 'first_name': firstName,
      if (roomId != null) 'room_id': roomId,
      if (avatar != null) 'avatar': avatar,
      if (isGroup != null) 'is_group': isGroup,
      if (presence != null) 'presence': presence,
    });
  }

  ContactsCompanion copyWith(
      {Value<String>? id,
      Value<String>? lastName,
      Value<String>? firstName,
      Value<String>? roomId,
      Value<String?>? avatar,
      Value<bool>? isGroup,
      Value<String?>? presence}) {
    return ContactsCompanion(
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      roomId: roomId ?? this.roomId,
      avatar: avatar ?? this.avatar,
      isGroup: isGroup ?? this.isGroup,
      presence: presence ?? this.presence,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String?>(avatar.value);
    }
    if (isGroup.present) {
      map['is_group'] = Variable<bool>(isGroup.value);
    }
    if (presence.present) {
      map['presence'] = Variable<String?>(presence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('lastName: $lastName, ')
          ..write('firstName: $firstName, ')
          ..write('roomId: $roomId, ')
          ..write('avatar: $avatar, ')
          ..write('isGroup: $isGroup, ')
          ..write('presence: $presence')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, DbContact> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  late final GeneratedColumn<String?> roomId = GeneratedColumn<String?>(
      'room_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  late final GeneratedColumn<String?> avatar = GeneratedColumn<String?>(
      'avatar', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _isGroupMeta = const VerificationMeta('isGroup');
  late final GeneratedColumn<bool?> isGroup = GeneratedColumn<bool?>(
      'is_group', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_group IN (0, 1))');
  final VerificationMeta _presenceMeta = const VerificationMeta('presence');
  late final GeneratedColumn<String?> presence = GeneratedColumn<String?>(
      'presence', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, lastName, firstName, roomId, avatar, isGroup, presence];
  @override
  String get aliasedName => _alias ?? 'contacts';
  @override
  String get actualTableName => 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<DbContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('is_group')) {
      context.handle(_isGroupMeta,
          isGroup.isAcceptableOrUnknown(data['is_group']!, _isGroupMeta));
    } else if (isInserting) {
      context.missing(_isGroupMeta);
    }
    if (data.containsKey('presence')) {
      context.handle(_presenceMeta,
          presence.isAcceptableOrUnknown(data['presence']!, _presenceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbContact.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(_db, alias);
  }
}

class DbUser extends DataClass implements Insertable<DbUser> {
  final String id;
  final String lastName;
  final String firstName;
  final String? username;
  final String? password;
  final String? avatar;
  final String? client_id;
  DbUser(
      {required this.id,
      required this.lastName,
      required this.firstName,
      this.username,
      this.password,
      this.avatar,
      this.client_id});
  factory DbUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbUser(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      avatar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      client_id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['last_name'] = Variable<String>(lastName);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String?>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String?>(password);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String?>(avatar);
    }
    if (!nullToAbsent || client_id != null) {
      map['client_id'] = Variable<String?>(client_id);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      lastName: Value(lastName),
      firstName: Value(firstName),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      client_id: client_id == null && nullToAbsent
          ? const Value.absent()
          : Value(client_id),
    );
  }

  factory DbUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DbUser(
      id: serializer.fromJson<String>(json['id']),
      lastName: serializer.fromJson<String>(json['lastName']),
      firstName: serializer.fromJson<String>(json['firstName']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      client_id: serializer.fromJson<String?>(json['client_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastName': serializer.toJson<String>(lastName),
      'firstName': serializer.toJson<String>(firstName),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'avatar': serializer.toJson<String?>(avatar),
      'client_id': serializer.toJson<String?>(client_id),
    };
  }

  DbUser copyWith(
          {String? id,
          String? lastName,
          String? firstName,
          String? username,
          String? password,
          String? avatar,
          String? client_id}) =>
      DbUser(
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        firstName: firstName ?? this.firstName,
        username: username ?? this.username,
        password: password ?? this.password,
        avatar: avatar ?? this.avatar,
        client_id: client_id ?? this.client_id,
      );
  @override
  String toString() {
    return (StringBuffer('DbUser(')
          ..write('id: $id, ')
          ..write('lastName: $lastName, ')
          ..write('firstName: $firstName, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('avatar: $avatar, ')
          ..write('client_id: $client_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          lastName.hashCode,
          $mrjc(
              firstName.hashCode,
              $mrjc(
                  username.hashCode,
                  $mrjc(password.hashCode,
                      $mrjc(avatar.hashCode, client_id.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUser &&
          other.id == this.id &&
          other.lastName == this.lastName &&
          other.firstName == this.firstName &&
          other.username == this.username &&
          other.password == this.password &&
          other.avatar == this.avatar &&
          other.client_id == this.client_id);
}

class UsersCompanion extends UpdateCompanion<DbUser> {
  final Value<String> id;
  final Value<String> lastName;
  final Value<String> firstName;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> avatar;
  final Value<String?> client_id;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.lastName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.avatar = const Value.absent(),
    this.client_id = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String lastName,
    required String firstName,
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.avatar = const Value.absent(),
    this.client_id = const Value.absent(),
  })  : id = Value(id),
        lastName = Value(lastName),
        firstName = Value(firstName);
  static Insertable<DbUser> custom({
    Expression<String>? id,
    Expression<String>? lastName,
    Expression<String>? firstName,
    Expression<String?>? username,
    Expression<String?>? password,
    Expression<String?>? avatar,
    Expression<String?>? client_id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastName != null) 'last_name': lastName,
      if (firstName != null) 'first_name': firstName,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (avatar != null) 'avatar': avatar,
      if (client_id != null) 'client_id': client_id,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? lastName,
      Value<String>? firstName,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? avatar,
      Value<String?>? client_id}) {
    return UsersCompanion(
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      username: username ?? this.username,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      client_id: client_id ?? this.client_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (username.present) {
      map['username'] = Variable<String?>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String?>(password.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String?>(avatar.value);
    }
    if (client_id.present) {
      map['client_id'] = Variable<String?>(client_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('lastName: $lastName, ')
          ..write('firstName: $firstName, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('avatar: $avatar, ')
          ..write('client_id: $client_id')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, DbUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  late final GeneratedColumn<String?> avatar = GeneratedColumn<String?>(
      'avatar', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _client_idMeta = const VerificationMeta('client_id');
  late final GeneratedColumn<String?> client_id = GeneratedColumn<String?>(
      'client_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, lastName, firstName, username, password, avatar, client_id];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<DbUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_client_idMeta,
          client_id.isAcceptableOrUnknown(data['client_id']!, _client_idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class DbMessage extends DataClass implements Insertable<DbMessage> {
  final String id;
  final String type;
  final String fromId;
  final String? fromName;
  final String? toId;
  final String? toName;
  final String textClm;
  final String roomId;
  final String originality;
  final String? attachment;
  final String? thumbnail;
  final String? originalId;
  final int sendTime;
  final int? size;
  final String status;
  final String? mime;
  final double? longitude;
  final double? latitude;
  DbMessage(
      {required this.id,
      required this.type,
      required this.fromId,
      this.fromName,
      this.toId,
      this.toName,
      required this.textClm,
      required this.roomId,
      required this.originality,
      this.attachment,
      this.thumbnail,
      this.originalId,
      required this.sendTime,
      this.size,
      required this.status,
      this.mime,
      this.longitude,
      this.latitude});
  factory DbMessage.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbMessage(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      fromId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_id'])!,
      fromName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_name']),
      toId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_id']),
      toName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_name']),
      textClm: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}text'])!,
      roomId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}room_id'])!,
      originality: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}originality'])!,
      attachment: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attachment']),
      thumbnail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail']),
      originalId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}original_id']),
      sendTime: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}send_time'])!,
      size: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}size']),
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status'])!,
      mime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mime']),
      longitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      latitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['from_id'] = Variable<String>(fromId);
    if (!nullToAbsent || fromName != null) {
      map['from_name'] = Variable<String?>(fromName);
    }
    if (!nullToAbsent || toId != null) {
      map['to_id'] = Variable<String?>(toId);
    }
    if (!nullToAbsent || toName != null) {
      map['to_name'] = Variable<String?>(toName);
    }
    map['text'] = Variable<String>(textClm);
    map['room_id'] = Variable<String>(roomId);
    map['originality'] = Variable<String>(originality);
    if (!nullToAbsent || attachment != null) {
      map['attachment'] = Variable<String?>(attachment);
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String?>(thumbnail);
    }
    if (!nullToAbsent || originalId != null) {
      map['original_id'] = Variable<String?>(originalId);
    }
    map['send_time'] = Variable<int>(sendTime);
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int?>(size);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || mime != null) {
      map['mime'] = Variable<String?>(mime);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double?>(longitude);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double?>(latitude);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      type: Value(type),
      fromId: Value(fromId),
      fromName: fromName == null && nullToAbsent
          ? const Value.absent()
          : Value(fromName),
      toId: toId == null && nullToAbsent ? const Value.absent() : Value(toId),
      toName:
          toName == null && nullToAbsent ? const Value.absent() : Value(toName),
      textClm: Value(textClm),
      roomId: Value(roomId),
      originality: Value(originality),
      attachment: attachment == null && nullToAbsent
          ? const Value.absent()
          : Value(attachment),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      originalId: originalId == null && nullToAbsent
          ? const Value.absent()
          : Value(originalId),
      sendTime: Value(sendTime),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      status: Value(status),
      mime: mime == null && nullToAbsent ? const Value.absent() : Value(mime),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
    );
  }

  factory DbMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DbMessage(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      fromId: serializer.fromJson<String>(json['fromId']),
      fromName: serializer.fromJson<String?>(json['fromName']),
      toId: serializer.fromJson<String?>(json['toId']),
      toName: serializer.fromJson<String?>(json['toName']),
      textClm: serializer.fromJson<String>(json['textClm']),
      roomId: serializer.fromJson<String>(json['roomId']),
      originality: serializer.fromJson<String>(json['originality']),
      attachment: serializer.fromJson<String?>(json['attachment']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
      originalId: serializer.fromJson<String?>(json['originalId']),
      sendTime: serializer.fromJson<int>(json['sendTime']),
      size: serializer.fromJson<int?>(json['size']),
      status: serializer.fromJson<String>(json['status']),
      mime: serializer.fromJson<String?>(json['mime']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      latitude: serializer.fromJson<double?>(json['latitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'fromId': serializer.toJson<String>(fromId),
      'fromName': serializer.toJson<String?>(fromName),
      'toId': serializer.toJson<String?>(toId),
      'toName': serializer.toJson<String?>(toName),
      'textClm': serializer.toJson<String>(textClm),
      'roomId': serializer.toJson<String>(roomId),
      'originality': serializer.toJson<String>(originality),
      'attachment': serializer.toJson<String?>(attachment),
      'thumbnail': serializer.toJson<String?>(thumbnail),
      'originalId': serializer.toJson<String?>(originalId),
      'sendTime': serializer.toJson<int>(sendTime),
      'size': serializer.toJson<int?>(size),
      'status': serializer.toJson<String>(status),
      'mime': serializer.toJson<String?>(mime),
      'longitude': serializer.toJson<double?>(longitude),
      'latitude': serializer.toJson<double?>(latitude),
    };
  }

  DbMessage copyWith(
          {String? id,
          String? type,
          String? fromId,
          String? fromName,
          String? toId,
          String? toName,
          String? textClm,
          String? roomId,
          String? originality,
          String? attachment,
          String? thumbnail,
          String? originalId,
          int? sendTime,
          int? size,
          String? status,
          String? mime,
          double? longitude,
          double? latitude}) =>
      DbMessage(
        id: id ?? this.id,
        type: type ?? this.type,
        fromId: fromId ?? this.fromId,
        fromName: fromName ?? this.fromName,
        toId: toId ?? this.toId,
        toName: toName ?? this.toName,
        textClm: textClm ?? this.textClm,
        roomId: roomId ?? this.roomId,
        originality: originality ?? this.originality,
        attachment: attachment ?? this.attachment,
        thumbnail: thumbnail ?? this.thumbnail,
        originalId: originalId ?? this.originalId,
        sendTime: sendTime ?? this.sendTime,
        size: size ?? this.size,
        status: status ?? this.status,
        mime: mime ?? this.mime,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );
  @override
  String toString() {
    return (StringBuffer('DbMessage(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('fromId: $fromId, ')
          ..write('fromName: $fromName, ')
          ..write('toId: $toId, ')
          ..write('toName: $toName, ')
          ..write('textClm: $textClm, ')
          ..write('roomId: $roomId, ')
          ..write('originality: $originality, ')
          ..write('attachment: $attachment, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('originalId: $originalId, ')
          ..write('sendTime: $sendTime, ')
          ..write('size: $size, ')
          ..write('status: $status, ')
          ..write('mime: $mime, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          type.hashCode,
          $mrjc(
              fromId.hashCode,
              $mrjc(
                  fromName.hashCode,
                  $mrjc(
                      toId.hashCode,
                      $mrjc(
                          toName.hashCode,
                          $mrjc(
                              textClm.hashCode,
                              $mrjc(
                                  roomId.hashCode,
                                  $mrjc(
                                      originality.hashCode,
                                      $mrjc(
                                          attachment.hashCode,
                                          $mrjc(
                                              thumbnail.hashCode,
                                              $mrjc(
                                                  originalId.hashCode,
                                                  $mrjc(
                                                      sendTime.hashCode,
                                                      $mrjc(
                                                          size.hashCode,
                                                          $mrjc(
                                                              status.hashCode,
                                                              $mrjc(
                                                                  mime.hashCode,
                                                                  $mrjc(
                                                                      longitude
                                                                          .hashCode,
                                                                      latitude
                                                                          .hashCode))))))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbMessage &&
          other.id == this.id &&
          other.type == this.type &&
          other.fromId == this.fromId &&
          other.fromName == this.fromName &&
          other.toId == this.toId &&
          other.toName == this.toName &&
          other.textClm == this.textClm &&
          other.roomId == this.roomId &&
          other.originality == this.originality &&
          other.attachment == this.attachment &&
          other.thumbnail == this.thumbnail &&
          other.originalId == this.originalId &&
          other.sendTime == this.sendTime &&
          other.size == this.size &&
          other.status == this.status &&
          other.mime == this.mime &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude);
}

class MessagesCompanion extends UpdateCompanion<DbMessage> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> fromId;
  final Value<String?> fromName;
  final Value<String?> toId;
  final Value<String?> toName;
  final Value<String> textClm;
  final Value<String> roomId;
  final Value<String> originality;
  final Value<String?> attachment;
  final Value<String?> thumbnail;
  final Value<String?> originalId;
  final Value<int> sendTime;
  final Value<int?> size;
  final Value<String> status;
  final Value<String?> mime;
  final Value<double?> longitude;
  final Value<double?> latitude;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.fromId = const Value.absent(),
    this.fromName = const Value.absent(),
    this.toId = const Value.absent(),
    this.toName = const Value.absent(),
    this.textClm = const Value.absent(),
    this.roomId = const Value.absent(),
    this.originality = const Value.absent(),
    this.attachment = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.originalId = const Value.absent(),
    this.sendTime = const Value.absent(),
    this.size = const Value.absent(),
    this.status = const Value.absent(),
    this.mime = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String type,
    required String fromId,
    this.fromName = const Value.absent(),
    this.toId = const Value.absent(),
    this.toName = const Value.absent(),
    required String textClm,
    required String roomId,
    required String originality,
    this.attachment = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.originalId = const Value.absent(),
    required int sendTime,
    this.size = const Value.absent(),
    this.status = const Value.absent(),
    this.mime = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        fromId = Value(fromId),
        textClm = Value(textClm),
        roomId = Value(roomId),
        originality = Value(originality),
        sendTime = Value(sendTime);
  static Insertable<DbMessage> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? fromId,
    Expression<String?>? fromName,
    Expression<String?>? toId,
    Expression<String?>? toName,
    Expression<String>? textClm,
    Expression<String>? roomId,
    Expression<String>? originality,
    Expression<String?>? attachment,
    Expression<String?>? thumbnail,
    Expression<String?>? originalId,
    Expression<int>? sendTime,
    Expression<int?>? size,
    Expression<String>? status,
    Expression<String?>? mime,
    Expression<double?>? longitude,
    Expression<double?>? latitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (fromId != null) 'from_id': fromId,
      if (fromName != null) 'from_name': fromName,
      if (toId != null) 'to_id': toId,
      if (toName != null) 'to_name': toName,
      if (textClm != null) 'text': textClm,
      if (roomId != null) 'room_id': roomId,
      if (originality != null) 'originality': originality,
      if (attachment != null) 'attachment': attachment,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (originalId != null) 'original_id': originalId,
      if (sendTime != null) 'send_time': sendTime,
      if (size != null) 'size': size,
      if (status != null) 'status': status,
      if (mime != null) 'mime': mime,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
    });
  }

  MessagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String>? fromId,
      Value<String?>? fromName,
      Value<String?>? toId,
      Value<String?>? toName,
      Value<String>? textClm,
      Value<String>? roomId,
      Value<String>? originality,
      Value<String?>? attachment,
      Value<String?>? thumbnail,
      Value<String?>? originalId,
      Value<int>? sendTime,
      Value<int?>? size,
      Value<String>? status,
      Value<String?>? mime,
      Value<double?>? longitude,
      Value<double?>? latitude}) {
    return MessagesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      toId: toId ?? this.toId,
      toName: toName ?? this.toName,
      textClm: textClm ?? this.textClm,
      roomId: roomId ?? this.roomId,
      originality: originality ?? this.originality,
      attachment: attachment ?? this.attachment,
      thumbnail: thumbnail ?? this.thumbnail,
      originalId: originalId ?? this.originalId,
      sendTime: sendTime ?? this.sendTime,
      size: size ?? this.size,
      status: status ?? this.status,
      mime: mime ?? this.mime,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (fromId.present) {
      map['from_id'] = Variable<String>(fromId.value);
    }
    if (fromName.present) {
      map['from_name'] = Variable<String?>(fromName.value);
    }
    if (toId.present) {
      map['to_id'] = Variable<String?>(toId.value);
    }
    if (toName.present) {
      map['to_name'] = Variable<String?>(toName.value);
    }
    if (textClm.present) {
      map['text'] = Variable<String>(textClm.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (originality.present) {
      map['originality'] = Variable<String>(originality.value);
    }
    if (attachment.present) {
      map['attachment'] = Variable<String?>(attachment.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String?>(thumbnail.value);
    }
    if (originalId.present) {
      map['original_id'] = Variable<String?>(originalId.value);
    }
    if (sendTime.present) {
      map['send_time'] = Variable<int>(sendTime.value);
    }
    if (size.present) {
      map['size'] = Variable<int?>(size.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (mime.present) {
      map['mime'] = Variable<String?>(mime.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double?>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double?>(latitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('fromId: $fromId, ')
          ..write('fromName: $fromName, ')
          ..write('toId: $toId, ')
          ..write('toName: $toName, ')
          ..write('textClm: $textClm, ')
          ..write('roomId: $roomId, ')
          ..write('originality: $originality, ')
          ..write('attachment: $attachment, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('originalId: $originalId, ')
          ..write('sendTime: $sendTime, ')
          ..write('size: $size, ')
          ..write('status: $status, ')
          ..write('mime: $mime, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages
    with TableInfo<$MessagesTable, DbMessage> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MessagesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _fromIdMeta = const VerificationMeta('fromId');
  late final GeneratedColumn<String?> fromId = GeneratedColumn<String?>(
      'from_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _fromNameMeta = const VerificationMeta('fromName');
  late final GeneratedColumn<String?> fromName = GeneratedColumn<String?>(
      'from_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _toIdMeta = const VerificationMeta('toId');
  late final GeneratedColumn<String?> toId = GeneratedColumn<String?>(
      'to_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _toNameMeta = const VerificationMeta('toName');
  late final GeneratedColumn<String?> toName = GeneratedColumn<String?>(
      'to_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _textClmMeta = const VerificationMeta('textClm');
  late final GeneratedColumn<String?> textClm = GeneratedColumn<String?>(
      'text', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  late final GeneratedColumn<String?> roomId = GeneratedColumn<String?>(
      'room_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _originalityMeta =
      const VerificationMeta('originality');
  late final GeneratedColumn<String?> originality = GeneratedColumn<String?>(
      'originality', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _attachmentMeta = const VerificationMeta('attachment');
  late final GeneratedColumn<String?> attachment = GeneratedColumn<String?>(
      'attachment', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  late final GeneratedColumn<String?> thumbnail = GeneratedColumn<String?>(
      'thumbnail', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _originalIdMeta = const VerificationMeta('originalId');
  late final GeneratedColumn<String?> originalId = GeneratedColumn<String?>(
      'original_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _sendTimeMeta = const VerificationMeta('sendTime');
  late final GeneratedColumn<int?> sendTime = GeneratedColumn<int?>(
      'send_time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  late final GeneratedColumn<int?> size = GeneratedColumn<int?>(
      'size', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String?> status = GeneratedColumn<String?>(
      'status', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant("pending"));
  final VerificationMeta _mimeMeta = const VerificationMeta('mime');
  late final GeneratedColumn<String?> mime = GeneratedColumn<String?>(
      'mime', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  late final GeneratedColumn<double?> longitude = GeneratedColumn<double?>(
      'longitude', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  late final GeneratedColumn<double?> latitude = GeneratedColumn<double?>(
      'latitude', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        fromId,
        fromName,
        toId,
        toName,
        textClm,
        roomId,
        originality,
        attachment,
        thumbnail,
        originalId,
        sendTime,
        size,
        status,
        mime,
        longitude,
        latitude
      ];
  @override
  String get aliasedName => _alias ?? 'messages';
  @override
  String get actualTableName => 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<DbMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('from_id')) {
      context.handle(_fromIdMeta,
          fromId.isAcceptableOrUnknown(data['from_id']!, _fromIdMeta));
    } else if (isInserting) {
      context.missing(_fromIdMeta);
    }
    if (data.containsKey('from_name')) {
      context.handle(_fromNameMeta,
          fromName.isAcceptableOrUnknown(data['from_name']!, _fromNameMeta));
    }
    if (data.containsKey('to_id')) {
      context.handle(
          _toIdMeta, toId.isAcceptableOrUnknown(data['to_id']!, _toIdMeta));
    }
    if (data.containsKey('to_name')) {
      context.handle(_toNameMeta,
          toName.isAcceptableOrUnknown(data['to_name']!, _toNameMeta));
    }
    if (data.containsKey('text')) {
      context.handle(_textClmMeta,
          textClm.isAcceptableOrUnknown(data['text']!, _textClmMeta));
    } else if (isInserting) {
      context.missing(_textClmMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('originality')) {
      context.handle(
          _originalityMeta,
          originality.isAcceptableOrUnknown(
              data['originality']!, _originalityMeta));
    } else if (isInserting) {
      context.missing(_originalityMeta);
    }
    if (data.containsKey('attachment')) {
      context.handle(
          _attachmentMeta,
          attachment.isAcceptableOrUnknown(
              data['attachment']!, _attachmentMeta));
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    if (data.containsKey('original_id')) {
      context.handle(
          _originalIdMeta,
          originalId.isAcceptableOrUnknown(
              data['original_id']!, _originalIdMeta));
    }
    if (data.containsKey('send_time')) {
      context.handle(_sendTimeMeta,
          sendTime.isAcceptableOrUnknown(data['send_time']!, _sendTimeMeta));
    } else if (isInserting) {
      context.missing(_sendTimeMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('mime')) {
      context.handle(
          _mimeMeta, mime.isAcceptableOrUnknown(data['mime']!, _mimeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbMessage.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(_db, alias);
  }
}

class DbInvitation extends DataClass implements Insertable<DbInvitation> {
  final String id;
  final String fromId;
  final String? fromName;
  final String? fromAvatar;
  final int sendTime;
  final bool incoming;
  final String status;
  DbInvitation(
      {required this.id,
      required this.fromId,
      this.fromName,
      this.fromAvatar,
      required this.sendTime,
      required this.incoming,
      required this.status});
  factory DbInvitation.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbInvitation(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      fromId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_id'])!,
      fromName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_name']),
      fromAvatar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_avatar']),
      sendTime: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}send_time'])!,
      incoming: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}incoming'])!,
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_id'] = Variable<String>(fromId);
    if (!nullToAbsent || fromName != null) {
      map['from_name'] = Variable<String?>(fromName);
    }
    if (!nullToAbsent || fromAvatar != null) {
      map['from_avatar'] = Variable<String?>(fromAvatar);
    }
    map['send_time'] = Variable<int>(sendTime);
    map['incoming'] = Variable<bool>(incoming);
    map['status'] = Variable<String>(status);
    return map;
  }

  InvitationsCompanion toCompanion(bool nullToAbsent) {
    return InvitationsCompanion(
      id: Value(id),
      fromId: Value(fromId),
      fromName: fromName == null && nullToAbsent
          ? const Value.absent()
          : Value(fromName),
      fromAvatar: fromAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(fromAvatar),
      sendTime: Value(sendTime),
      incoming: Value(incoming),
      status: Value(status),
    );
  }

  factory DbInvitation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DbInvitation(
      id: serializer.fromJson<String>(json['id']),
      fromId: serializer.fromJson<String>(json['fromId']),
      fromName: serializer.fromJson<String?>(json['fromName']),
      fromAvatar: serializer.fromJson<String?>(json['fromAvatar']),
      sendTime: serializer.fromJson<int>(json['sendTime']),
      incoming: serializer.fromJson<bool>(json['incoming']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromId': serializer.toJson<String>(fromId),
      'fromName': serializer.toJson<String?>(fromName),
      'fromAvatar': serializer.toJson<String?>(fromAvatar),
      'sendTime': serializer.toJson<int>(sendTime),
      'incoming': serializer.toJson<bool>(incoming),
      'status': serializer.toJson<String>(status),
    };
  }

  DbInvitation copyWith(
          {String? id,
          String? fromId,
          String? fromName,
          String? fromAvatar,
          int? sendTime,
          bool? incoming,
          String? status}) =>
      DbInvitation(
        id: id ?? this.id,
        fromId: fromId ?? this.fromId,
        fromName: fromName ?? this.fromName,
        fromAvatar: fromAvatar ?? this.fromAvatar,
        sendTime: sendTime ?? this.sendTime,
        incoming: incoming ?? this.incoming,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('DbInvitation(')
          ..write('id: $id, ')
          ..write('fromId: $fromId, ')
          ..write('fromName: $fromName, ')
          ..write('fromAvatar: $fromAvatar, ')
          ..write('sendTime: $sendTime, ')
          ..write('incoming: $incoming, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fromId.hashCode,
          $mrjc(
              fromName.hashCode,
              $mrjc(
                  fromAvatar.hashCode,
                  $mrjc(sendTime.hashCode,
                      $mrjc(incoming.hashCode, status.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbInvitation &&
          other.id == this.id &&
          other.fromId == this.fromId &&
          other.fromName == this.fromName &&
          other.fromAvatar == this.fromAvatar &&
          other.sendTime == this.sendTime &&
          other.incoming == this.incoming &&
          other.status == this.status);
}

class InvitationsCompanion extends UpdateCompanion<DbInvitation> {
  final Value<String> id;
  final Value<String> fromId;
  final Value<String?> fromName;
  final Value<String?> fromAvatar;
  final Value<int> sendTime;
  final Value<bool> incoming;
  final Value<String> status;
  const InvitationsCompanion({
    this.id = const Value.absent(),
    this.fromId = const Value.absent(),
    this.fromName = const Value.absent(),
    this.fromAvatar = const Value.absent(),
    this.sendTime = const Value.absent(),
    this.incoming = const Value.absent(),
    this.status = const Value.absent(),
  });
  InvitationsCompanion.insert({
    required String id,
    required String fromId,
    this.fromName = const Value.absent(),
    this.fromAvatar = const Value.absent(),
    required int sendTime,
    required bool incoming,
    required String status,
  })  : id = Value(id),
        fromId = Value(fromId),
        sendTime = Value(sendTime),
        incoming = Value(incoming),
        status = Value(status);
  static Insertable<DbInvitation> custom({
    Expression<String>? id,
    Expression<String>? fromId,
    Expression<String?>? fromName,
    Expression<String?>? fromAvatar,
    Expression<int>? sendTime,
    Expression<bool>? incoming,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromId != null) 'from_id': fromId,
      if (fromName != null) 'from_name': fromName,
      if (fromAvatar != null) 'from_avatar': fromAvatar,
      if (sendTime != null) 'send_time': sendTime,
      if (incoming != null) 'incoming': incoming,
      if (status != null) 'status': status,
    });
  }

  InvitationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? fromId,
      Value<String?>? fromName,
      Value<String?>? fromAvatar,
      Value<int>? sendTime,
      Value<bool>? incoming,
      Value<String>? status}) {
    return InvitationsCompanion(
      id: id ?? this.id,
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      fromAvatar: fromAvatar ?? this.fromAvatar,
      sendTime: sendTime ?? this.sendTime,
      incoming: incoming ?? this.incoming,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromId.present) {
      map['from_id'] = Variable<String>(fromId.value);
    }
    if (fromName.present) {
      map['from_name'] = Variable<String?>(fromName.value);
    }
    if (fromAvatar.present) {
      map['from_avatar'] = Variable<String?>(fromAvatar.value);
    }
    if (sendTime.present) {
      map['send_time'] = Variable<int>(sendTime.value);
    }
    if (incoming.present) {
      map['incoming'] = Variable<bool>(incoming.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvitationsCompanion(')
          ..write('id: $id, ')
          ..write('fromId: $fromId, ')
          ..write('fromName: $fromName, ')
          ..write('fromAvatar: $fromAvatar, ')
          ..write('sendTime: $sendTime, ')
          ..write('incoming: $incoming, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $InvitationsTable extends Invitations
    with TableInfo<$InvitationsTable, DbInvitation> {
  final GeneratedDatabase _db;
  final String? _alias;
  $InvitationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _fromIdMeta = const VerificationMeta('fromId');
  late final GeneratedColumn<String?> fromId = GeneratedColumn<String?>(
      'from_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _fromNameMeta = const VerificationMeta('fromName');
  late final GeneratedColumn<String?> fromName = GeneratedColumn<String?>(
      'from_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _fromAvatarMeta = const VerificationMeta('fromAvatar');
  late final GeneratedColumn<String?> fromAvatar = GeneratedColumn<String?>(
      'from_avatar', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _sendTimeMeta = const VerificationMeta('sendTime');
  late final GeneratedColumn<int?> sendTime = GeneratedColumn<int?>(
      'send_time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _incomingMeta = const VerificationMeta('incoming');
  late final GeneratedColumn<bool?> incoming = GeneratedColumn<bool?>(
      'incoming', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (incoming IN (0, 1))');
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String?> status = GeneratedColumn<String?>(
      'status', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, fromId, fromName, fromAvatar, sendTime, incoming, status];
  @override
  String get aliasedName => _alias ?? 'invitations';
  @override
  String get actualTableName => 'invitations';
  @override
  VerificationContext validateIntegrity(Insertable<DbInvitation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_id')) {
      context.handle(_fromIdMeta,
          fromId.isAcceptableOrUnknown(data['from_id']!, _fromIdMeta));
    } else if (isInserting) {
      context.missing(_fromIdMeta);
    }
    if (data.containsKey('from_name')) {
      context.handle(_fromNameMeta,
          fromName.isAcceptableOrUnknown(data['from_name']!, _fromNameMeta));
    }
    if (data.containsKey('from_avatar')) {
      context.handle(
          _fromAvatarMeta,
          fromAvatar.isAcceptableOrUnknown(
              data['from_avatar']!, _fromAvatarMeta));
    }
    if (data.containsKey('send_time')) {
      context.handle(_sendTimeMeta,
          sendTime.isAcceptableOrUnknown(data['send_time']!, _sendTimeMeta));
    } else if (isInserting) {
      context.missing(_sendTimeMeta);
    }
    if (data.containsKey('incoming')) {
      context.handle(_incomingMeta,
          incoming.isAcceptableOrUnknown(data['incoming']!, _incomingMeta));
    } else if (isInserting) {
      context.missing(_incomingMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbInvitation map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbInvitation.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $InvitationsTable createAlias(String alias) {
    return $InvitationsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $InvitationsTable invitations = $InvitationsTable(this);
  late final UserDao userDao = UserDao(this as MyDatabase);
  late final ContactDao contactDao = ContactDao(this as MyDatabase);
  late final MessageDao messageDao = MessageDao(this as MyDatabase);
  late final InvitationDao invitationDao = InvitationDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [contacts, users, messages, invitations];
}
