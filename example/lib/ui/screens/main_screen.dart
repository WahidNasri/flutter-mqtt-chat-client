import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:example/database/chat_db.dart';
import 'package:example/ui/pages/calls_page.dart';
import 'package:example/ui/pages/chats_page.dart';
import 'package:example/ui/pages/rooms_page.dart';
import 'package:example/ui/pages/groups_page.dart';
import 'package:example/ui/pages/profile_page.dart';
import 'package:example/ui/screens/login_screen.dart';
import 'package:example/ui/screens/new_invitation_screen.dart';
import 'package:example/ui/widgets/connectivity_listener_text.dart';
import 'package:example/ui/widgets/local_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqchat/chat_app.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final pages = [
    const RecentChatsPage(),
    const RoomsPage(),
    const CallsPage(),
    ProfilePage(
      key: UniqueKey(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: LocalUserAvatar(),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _addChat();
                  },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    _logout();
                  },
                  icon: const Icon(Icons.logout))
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Flutter MqChat Client"),
                ConnectivityListenerText()
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).colorScheme.primaryVariant,
            child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                /// Home
                SalomonBottomBarItem(
                    icon: const Icon(Icons.chat),
                    title: const Text("Chats"),
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white24),

                /// Likes
                SalomonBottomBarItem(
                    icon: const Icon(Icons.group),
                    title: const Text("Groups"),
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white24),

                /// Search
                SalomonBottomBarItem(
                    icon: const Icon(Icons.call),
                    title: const Text("Calls"),
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white24),

                /// Profile
                SalomonBottomBarItem(
                    icon: const Icon(Icons.person),
                    title: const Text("Profile"),
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white24),
              ],
            ),
          ),
          body: pages[_currentIndex]),
    );
  }

  _logout() {
    showAdaptiveActionSheet(
        context: context,
        title: const Text('Are you sure you want to logout?'),
        actions: [
          BottomSheetAction(
              title: const Text('Logout'),
              onPressed: () {
                ChatApp.instance()!.disconnect();
                AppDatabase.instance().then((db) {
                  if (db != null) {
                    db.deleteAll();
                  }
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              }),
          BottomSheetAction(
              title: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ]);
  }

  _addChat() {
    showAdaptiveActionSheet(
        context: context,
        title: const Text('New Chat'),
        actions: [
          BottomSheetAction(
              title: const Text('Create a group Chat'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => const NewInvitationScreen()));
              }),
          BottomSheetAction(
              title: const Text('Invite an existing user to Chat'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => const NewInvitationScreen()));
              }),
        ]);
  }
}
