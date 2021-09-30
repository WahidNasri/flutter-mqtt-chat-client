import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/chat_db_pages.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/profile_page.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/rooms_db_page.dart';
import 'package:flutter_mqtt/ui/screens/main/chats_page.dart';
import 'package:flutter_mqtt/ui/screens/main/groups_page.dart';
import 'package:flutter_mqtt/ui/views/new_chat_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart'
    as cs;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final pages = [
    ChatsPage(
      key: UniqueKey(),
    ),
    Center(child: GroupsPage()),
    Center(child: Text("Calls")),
    ProfilePage(
      key: UniqueKey(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: StreamBuilder<DbUser?>(
              stream: AppData.instance()!.usersHandler.getLocalUserAsync(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: "my_avatar",
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(snapshot.data!.avatar ??
                              "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 0,
                  width: 0,
                );
              }),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Flutter MQTT Chat"),
              StreamBuilder<cs.ConnectionState>(
                  stream:
                      ChatApp.instance()!.clientHandler.connectionStateStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        snapshot.error.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      );
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data.toString().split(".")[1],
                          style: TextStyle(fontSize: 12));
                    }
                    return Text("Loading Connection State...",
                        style: TextStyle(fontSize: 15));
                  })
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showRoomsSheet();
                },
                icon: Icon(Icons.add_comment_outlined))
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primaryVariant,
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                  icon: Icon(Icons.chat),
                  title: Text("Chats"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white24),

              /// Likes
              SalomonBottomBarItem(
                  icon: Icon(Icons.group),
                  title: Text("Groups"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white24),

              /// Search
              SalomonBottomBarItem(
                  icon: Icon(Icons.call),
                  title: Text("Calls"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white24),

              /// Profile
              SalomonBottomBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white24),
            ],
          ),
        ),
        body: pages[_currentIndex],
      ),
    );
  }

  void _showRoomsSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => NewChatView(
              openRoom: (contact) {
                _openRoom(context, contact);
              },
            ));
  }

  _openRoom(BuildContext context, ContactChat contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatUIDBPage(contactChat: contact)),
    );
  }
}

class ColoredSafeArea extends StatelessWidget {
  final Widget? child;
  final Color? color;

  const ColoredSafeArea({Key? key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).colorScheme.primaryVariant,
      child: SafeArea(
        child: child ?? SizedBox(),
      ),
    );
  }
}
