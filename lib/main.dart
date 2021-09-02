import 'package:flutter/material.dart';
import 'package:flutter_mqtt/ui/screens/chat_ui_page.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}
