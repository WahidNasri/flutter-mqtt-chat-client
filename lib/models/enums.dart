import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  @JsonValue("ChatText")
  chatText,
  @JsonValue("ChatImage")
  chatImage,
  @JsonValue("ChatVideo")
  chatVideo,
  @JsonValue("ChatAudio")
  chatAudio,
  @JsonValue("ChatDocument")
  chatDocument,
  @JsonValue("ChatLocation")
  chatLocation,
  @JsonValue("ChatContact")
  chatContact,

  @JsonValue("InvitationRequest")
  invitationRequest,
  @JsonValue("InvitationResponseAccept")
  invitationResponseAccept,
  @JsonValue("InvitationResponseReject")
  invitationResponseReject,

  @JsonValue("Presence")
  presence,

  @JsonValue("ChatMarker")
  chatMarker,

  @JsonValue("Typing")
  typing,

  @JsonValue("Membership")
  membership,

  @JsonValue("AddGroup")
  addGroup,

  @JsonValue("RemoveGroup")
  removeGroup
}
enum PresenceType {
  @JsonValue("Available")
  available,

  @JsonValue("Away")
  away,

  @JsonValue("Unavailable")
  unavailable
}
enum MessageOriginality {
  @JsonValue("Original")
  original,
  @JsonValue("Reply")
  reply,
  @JsonValue("Forward")
  forward
}
enum ChatMarker {
  @JsonValue("sent")
  sent,
  @JsonValue("delivered")
  delivered,
  @JsonValue("displayed")
  displayed
}

enum ConnectionState {
  disconnecting,

  /// MQTT Connection is not currently connected to any broker.
  disconnected,

  /// The MQTT Connection is in the process of connecting to the broker.
  connecting,

  /// The MQTT Connection is currently connected to the broker.
  connected,

  /// The MQTT Connection is faulted and no longer communicating
  /// with the broker.
  faulted
}
