import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/ui/screens/details/invitations_page.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';
import 'package:flutter_mqtt/ui/widgets/menu_action_item.dart';
import 'package:flutter_mqtt/ui/widgets/menu_action_item_switch.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _onLogout(context);
        },
        label: Text("Logout"),
        backgroundColor: Colors.red,
        icon: Icon(Icons.logout),
      ),
      body: Center(
        child: StreamBuilder<DbUser?>(
            stream: AppData.instance()!.usersHandler.getLocalUserAsync(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                var user = snapshot.data;
                var fnameController =
                    TextEditingController(text: user!.firstName);
                var lnameController =
                    TextEditingController(text: user.lastName);
                var uname = TextEditingController(text: user.username);
                return Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Hero(
                      tag: "my_avatar",
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(user.avatar ?? ""),
                        radius: 100,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(user.username!, style: TextStyle(fontSize: 24),),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Column(
                            children: [
                              _profileInfoWidget(
                                  fnameController, lnameController),
                              Divider(),
                              _invitationsWidget(),
                              Divider(),
                              _allowInvitationsWidget()
                            ],
                          ),
                        ))
                  ],
                );
              }
              return Text("No User record");
            }),
      ),
    );
  }

  Widget _profileInfoWidget(
      TextEditingController fnameController,
      TextEditingController lnameController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: fnameController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "First Name",
              hintStyle: TextStyle(color: Colors.grey[400])),
        ),
        Divider(),
        TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: lnameController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Last Name",
              hintStyle: TextStyle(color: Colors.grey[400])),
        ),
      ],
    );
  }

  Widget _invitationsWidget() {
    return StreamBuilder<int>(
        stream: AppData.instance()!.invitationsHandler.getInvitationsCount(),
        builder: (context, snapshot) {
          return MenuActionItem(
            title: "Invitations",
            trailingText: snapshot.hasData ? snapshot.data.toString() : "0",
            leading: Icon(Icons.wb_incandescent_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvitationsPage()),
              );
            },
          );
        });
  }
  Widget _allowInvitationsWidget(){
    return MenuSwitchItem(title: "Allow others to invite me", active: true, onChanged: (v){}, leading: Icon(Icons.door_sliding_outlined),);
  }

  _onLogout(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'No'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Yes');
              AppData.instance()!.deleteAllAndDisconnect();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
