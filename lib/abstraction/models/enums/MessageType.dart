enum MessageType {
  ChatText,
  ChatImage,
  ChatVideo,
  ChatAudio,
  ChatDocument,
  ChatLocation,
  ChatContact,

  EventInvitationRequest,
  EventInvitationResponseAccept,
  EventInvitationResponseReject,

  Presence,

  ChatMarker,

  Typing,

  CreateGroup,
  RemoveGroup,
  AddUsersToGroup,
  RemoveGroupMembers,
}
