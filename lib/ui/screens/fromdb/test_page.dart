import 'package:flutter/material.dart';
import 'package:flutter_mqtt/ui/screens/startup_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Add the observer.
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
  }

  _onLayoutDone(_) {
    print("##### LOADED ");
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(">>>>>>> " + state.toString());
    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        // widget is paused
        break;
      case AppLifecycleState.detached:
        // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _navigate,
            child: Text("Navigate"),
          ),
        ),
      );


  _navigate() {
    print("#### NAVIGATED");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartupPage()),
    ).then((value) => {print("#### RETURNED")});
  }
}
