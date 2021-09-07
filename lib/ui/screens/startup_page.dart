import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';
import 'package:flutter_mqtt/ui/screens/rooms_db_page.dart';
import 'package:flutter_mqtt/ui/screens/rooms_page.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  DbUser? _user;
  @override
  void initState() {
    MyDatabase.instance()!.userDao.getUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Startup page"),
        ),
        body: Padding(padding: EdgeInsets.all(20), child: _body()));
  }

  Widget _body() {
    if (_user == null) {
      return Center(
        child: Column(
          children: [
            Text("No logged in user"),
            ElevatedButton(
                onPressed: _onLogin,
                child: Text("Log in"))
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User found: " + _user!.firstName, style: TextStyle(fontSize: 25),),
            SizedBox(height: 20,),
            FloatingActionButton(
                onPressed: _onGoChat,
                child: Icon(Icons.arrow_right_alt_outlined))
          ],
        ),
      );
    }
  }
  void _onGoChat(){
    MyDatabase.instance()!.userDao.getUser().then((users) => {
      if (users != null)
        {
          ChatApp.instance()!.clientHandler.connect(
              clientId: users.client_id!,
              password: users.password!,
              username: users.username!)
        }
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RoomsDBPage()),
    );
  }
  void _onLogin(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
