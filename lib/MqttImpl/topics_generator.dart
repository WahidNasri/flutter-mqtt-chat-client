class TopicsNamesGenerator {
  static String getEventsTopicForBareRoom(String bareRoom) {
    return "events/" + bareRoom;
  }

  static String getPresenceTopicOfBareId(String bareId) {
    return "presence/" + bareId;
  }

  static String getPersonalEventsForBareId(String bareId) {
    return "events/" + bareId;
  }

  static String getChattingTopicForBareRoom(String bareRoom) {
    return "messages/" + bareRoom;
  }

  static String getArchivesRoomsTopic(String clientId) {
    return "archivesrooms/" + clientId;
  }

  static String getArchivesMessagesTopic(String clientId) {
    return "archivesmessages/" + clientId;
  }

  static String getArchivesMyIdTopic(String clientId) {
    return "archivesmyid/" + clientId;
  }
}
