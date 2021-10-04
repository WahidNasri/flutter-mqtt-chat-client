import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/enums/PresenceType.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/startup_page.dart';

import 'abstraction/models/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App State = $state');

    DbUser? user = AppData.instance()!.user;
    if(user != null){
      if(state == AppLifecycleState.inactive || state == AppLifecycleState.paused){
        ChatApp.instance()!.eventsSender.sendPresence(PresenceType.Away, user.id);
      }
      else if(state == AppLifecycleState.resumed){
        ChatApp.instance()!.eventsSender.sendPresence(PresenceType.Available, user.id);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StartupPage());
  }
}
