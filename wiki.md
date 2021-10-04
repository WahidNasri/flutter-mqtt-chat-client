### Use Flutter-MQTT-Chat-Client as a library to your project

## 1. Login
```dart
bool connected = await ChatApp.instance()!.clientHandler.connect(
        host: "broker.url.com",
        username: "user@test.com",
        password: "user_pass");
```

## 2. Listen to my profile changes
```dart
ChatApp.instance()!.archiveHandler.getUser().listen((user) {
      //insert/update user to database
    });
```

## 3. Listen to rooms
Whenever the logged in user is added to a room (or room details changed), the room details will be added to the Conversations stream.
```dart
ChatApp.instance()!.archiveHandler.getAllConversations().listen((rooms) {
      //insert/update rooms on the Database
    });
```    

## 4. Listen to new messages
```dart
ChatApp.instance()!.messageReader.getChatMessages().listen((message) {
      var dbMessage = message.toDbMessage();
      // insert the message to the database
      // send chatmarker if the message is not mine
    });
```

## 5. Listen to ChatMarkers
```dart
ChatApp.instance()!
        .messageReader
        .getChatMarkerMessages()
        .listen((markerMessage) {

      String messageId = markerMessage.referenceId;
      if (markerMessage.status == ChatMarker.displayed) {
          //update the database record
      } else if (markerMessage.status == ChatMarker.delivered) {
          //update the database record
      }
    });
```

## 6. Listen to new chat invitations
```dart
ChatApp.instance()!
        .invitationHandler
        .newInvitationsStream()
        .listen((invitation) {
          if(invitation.type == MessageType.EventInvitationRequest) {
            //new invitation request
            //insert invitation record to the database, notify the user
          }
          if(invitation.type == MessageType.EventInvitationResponseAccept || invitation.type == MessageType.EventInvitationResponseReject) {
            //responded to invitation, update the local record and wait the server to sync the new contact (if accepted).
            //Do not insert a room, the user will receive a new room details triggered by getAllConversations()
          }
    });
```

## 7. Listen to invitatioin updates
We use this to listen to the invitations that the user has sent. It could be:
- Info: When receive an affirmation that the invitation is sent
- Error: When there is an error (like the user is not found)
- 
```dart
ChatApp.instance()!
        .invitationHandler
        .invitationUpdatesStream()
        .listen((invitation) {
      if (invitation.invitationMessageType == InvitationMessageType.INFO) {
       //update the invitation record to be confirmed
      }
      else if (invitation.invitationMessageType == InvitationMessageType.ERROR) {
        //notify the user, and delete the record in inserted
      }
    });
```

## 8. Send a text Message
```dart
ChatMessage newMessage = ChatMessage(
        id: "generated_random_id",
        type: MessageType.ChatText,
        text: "Hello there",
        roomId: "[room_id]",
        fromId: "[my_id]",//optional
        sendTime: DateTime.now().millisecondsSinceEpoch,
        fromName: "[my_name]");
```
### 8.1 Send the message as regular message
```dart
ChatApp.instance()!
          .messageSender
          .sendChatMessage(newMessage, "[room_id]");
```

### 8.2 Send the message as a reply to another message
```dart
ChatMessage replyToMessage = ...; //the message to reply to
ChatApp.instance()!
          .messageSender
          .replyToMessage(replyToMessage, newMessage, widget.contactChat.roomId);
```

## 9. Send File Message
```dart
 ChatApp.instance()!.messageSender.sendFileChatMessage(
          type: MessageType.ChatImage,//for example
          fileLocalPath: path,
          room: "[room_id]");
```

## 10. Send typing indicator
```dart
ChatApp.instance()!
          .eventsSender
          .sendIsTyping(true, "[room_id]");
```

## 11. Listen to typing indicator
```dart
ChatApp.instance()!.messageReader.getTypingMessages().listen((event) {
    //using event.roomId and event.isTyping and event.fromId, update the ui state
    
    });
```

## 12. Send new chat invitation
```dart
ChatApp.instance()!
        .eventsSender
        .sendInvitation("[invitee_username]", "[invitation_random_id]");
```
