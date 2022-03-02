import 'package:example/mqtt_db_bridge/app_data.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:example/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqchat/chat_app.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance!.addObserver(this);
    AppData();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final user = ref.watch(userProvider);
    if (user.user != null) {
      if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        ChatApp.instance()!
            .eventsSender
            .sendPresence(PresenceType.away, user.user!.id);
      } else if (state == AppLifecycleState.resumed) {
        ChatApp.instance()!
            .eventsSender
            .sendPresence(PresenceType.available, user.user!.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MqChat Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
