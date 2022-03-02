extension TopicsExtensions on String {
  bool get isChattingTopic {
    return toLowerCase().startsWith("messages/");
  }

  bool get isRoomEventsTopic {
    return toLowerCase().startsWith("events/");
  }

  bool get isPresenceTopic {
    return toLowerCase().startsWith("presence/");
  }

  bool get isArchivesTopic {
    return toLowerCase().startsWith("archives");
  }

  bool get isMembershipArchivesTopic {
    return toLowerCase().startsWith("archives/rooms/");
  }

  bool get isInvitationsArchivesTopic {
    return toLowerCase().startsWith("archives/invitations/");
  }

  bool get isMyProfileArchiveTopic {
    return toLowerCase().startsWith("archives/me/");
  }

  bool get isMessagesArchiveTopic {
    return toLowerCase().startsWith("archives/messages/");
  }

  bool get isPersonalEventTopic {
    return toLowerCase().startsWith("personalevents/");
  }

  String get toChattingTopic {
    return "messages/" + this;
  }

  String get toFileSendingTopic {
    return "filemessages/" + this;
  }

  String get toRoomEventsTopic {
    return "events/" + this;
  }

  String get toPresenceTopic {
    return "presence/" + this;
  }

  String get toMembershipArchivesTopic {
    return "archives/rooms/" + this;
  }

  String get toInvitationsArchivesTopic {
    return "archives/invitations/" + this;
  }

  String get toMyProfileArchiveTopic {
    return "archives/me/" + this;
  }

  String get toMessagesArchiveTopic {
    return "archives/messages/" + this;
  }

  String get toPersonalEventTopic {
    return "personalevents/" + this;
  }

  String get toInvitationEventTopic {
    return "invitations/" + this;
  }

  String get toGroupCrudTopic {
    return "muc/" + this;
  }
}
