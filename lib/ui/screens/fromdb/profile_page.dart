import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Center(
        child: StreamBuilder<DbUser?>(
            stream: AppData.instance()!.usersHandler.getLocalUserAsync(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                var user = snapshot.data;
                var fnameController = TextEditingController(text: user!.firstName);
                var lnameController = TextEditingController(text: user!.lastName);
                var uname = TextEditingController(text: user!.username);
                return Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      foregroundImage: NetworkImage(user!.avatar ?? ""),
                      radius: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    controller: uname,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                  ),
                                  Divider(),
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    controller: fnameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "First Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                  Divider(),
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    controller: lnameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Last Name",
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                  ),
                                  Divider()
                                ],
                              ),
                            )))
                  ],
                );
              }
              return Text("No User record");
            }),
      ),
    );
  }
}
