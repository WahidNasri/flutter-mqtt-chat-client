// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactChat.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ContactChatCopyWith on ContactChat {
  ContactChat copyWith({
    String? avatar,
    String? firstName,
    String? id,
    bool? isGroup,
    String? lastName,
    PresenceType? presence,
    String? roomId,
  }) {
    return ContactChat(
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
      isGroup: isGroup ?? this.isGroup,
      lastName: lastName ?? this.lastName,
      presence: presence ?? this.presence,
      roomId: roomId ?? this.roomId,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactChat _$ContactChatFromJson(Map<String, dynamic> json) {
  return ContactChat(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    id: json['id'] as String,
    avatar: json['avatar'] as String?,
    roomId: json['roomId'] as String,
    isGroup: json['isGroup'] as bool?,
    presence: _$enumDecodeNullable(_$PresenceTypeEnumMap, json['presence']),
  );
}

Map<String, dynamic> _$ContactChatToJson(ContactChat instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'id': instance.id,
      'avatar': instance.avatar,
      'roomId': instance.roomId,
      'presence': _$PresenceTypeEnumMap[instance.presence],
      'isGroup': instance.isGroup,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$PresenceTypeEnumMap = {
  PresenceType.Available: 'Available',
  PresenceType.Away: 'Away',
  PresenceType.Unavailable: 'Unavailable',
};
