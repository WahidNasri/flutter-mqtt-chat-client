import 'package:example/database/models/user.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:example/ui/screens/login_screen.dart';
import 'package:example/ui/screens/main_screen.dart';
import 'package:example/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_mqtt/chat_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<UserProvider>(userProvider, (previous, state) async {
      if (state.user != null) {
        _goToHome();

        final connected = await ChatApp.instance()!.clientHandler.connect(
            host: await AppPreferences.brokerHost(),
            username: state.user!.username,
            password: state.user!.password,
            clientId: state.user!.clientId);
      } else {
        _goToLogin();
      }
    });
    return Container();
  }

  _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }
}
