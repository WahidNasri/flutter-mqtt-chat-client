import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/preferences.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/rooms_db_page.dart';
import 'package:flutter_mqtt/ui/screens/main/main_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _hostController = TextEditingController();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  initState() {
    AppPreferences.brokerHost().then((host) {
      _hostController.text = host ?? "";
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_chat.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 50),
                Color.fromRGBO(143, 148, 251, .6),
              ])),
                    //color: Theme.of(context).primaryColor,
                    child: Center(
                        child: Text("Flutter MQTT Chat Client",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white))),
                  )),
              Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]!))),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: _hostController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Host",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]!))),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: InkWell(
                            onTap: () {
                              _loginTap(context);
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  _loginTap(BuildContext context) async {
    if (_hostController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("All Fields are mandatory"),
      ));
      return;
    }
    bool connected = await ChatApp.instance()!.clientHandler.connect(
        host: _hostController.text,
        username: _usernameController.text,
        password: _passwordController.text);
    if (connected) {
      AppPreferences.setHost(_hostController.text);

      AppData.instance()!.usersHandler.storeWaitingCredentials(
          _usernameController.text.trim(), _passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Could not log in"),
      ));
    }
  }
}
