import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';
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
    MyDatabase().userDao.getUser().then((users) {
      if (users.length > 0) {
        setState(() {
          _user = users[0];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: EdgeInsets.all(20), child: _body()));
  }

  Widget _body() {
    if (_user == null) {
      return Center(
        child: Column(
          children: [
            Text("No logged in user"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Log in"))
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            Text("User found: " + _user!.firstName),
            ElevatedButton(
                onPressed: () {
                  MyDatabase().userDao.getUser().then((users) => {
                        if (users.length > 0)
                          {
                            ChatApp.instance()!.clientHandler.connect(
                                clientId: users[0].client_id!,
                                password: "123",
                                username: "wahid@test.com")
                          }
                      });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoomsPage()),
                  );
                },
                child: Text("Go Chat"))
          ],
        ),
      );
    }
  }
}
