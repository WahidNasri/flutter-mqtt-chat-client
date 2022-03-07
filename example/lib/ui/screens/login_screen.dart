import 'package:example/ui/screens/main_screen.dart';
import 'package:example/utils/preferences.dart';
import 'package:example/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqchat/chat_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _hostController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    AppPreferences.brokerHost().then((host) {
      _hostController.text = host ?? "";
    });

    _usernameController.text = 'wahid@test.com';
    _passwordController.text = '123';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DecoratedBox(
          decoration: const BoxDecoration(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.2),
                              blurRadius: 20.0,
                              offset: Offset(0, 5))
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.url,
                            validator: (host) =>
                                AppValidators.isValidHost(host),
                            textInputAction: TextInputAction.next,
                            controller: _hostController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Host",
                                isCollapsed: true,
                                prefixIcon: const Icon(Icons.rss_feed),
                                contentPadding: const EdgeInsets.all(10),
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                          const Divider(),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) =>
                                AppValidators.isValidEmail(email),
                            textInputAction: TextInputAction.next,
                            controller: _usernameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                isCollapsed: true,
                                prefixIcon: const Icon(Icons.mail),
                                contentPadding: const EdgeInsets.all(10),
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                          const Divider(),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (pass) =>
                                AppValidators.isValidPassword(pass),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                contentPadding: const EdgeInsets.all(10),
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _loginTap(context);
                        }
                      },
                      child: Text("Log in")),
                ],
              )),
        ));
  }

  _loginTap(BuildContext context) async {
    bool connected = await ChatApp.instance()!.clientHandler.connect(
        host: _hostController.text,
        username: _usernameController.text,
        password: _passwordController.text);
    if (connected) {
      AppPreferences.setHost(_hostController.text);

      AppPreferences.setUsername(_usernameController.text);
      AppPreferences.setPassword(_passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Could not log in"),
      ));
    }
  }

  @override
  void dispose() {
    _hostController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
