import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/widgets/avatar_cancellable.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  int globalCount = 0;
  List<ContactChat> selected = List<ContactChat>.empty(growable: true);
  TextEditingController _groupNameController = TextEditingController();

  int maxNameLength = 25;
  int currentNameLength = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New Group"),
            Text(selected.length.toString() + "/" + globalCount.toString())
          ],
        ),
      ),
      body: Column(
        children: [
          _groupNameView(),
          Divider(),
          _selectedView(),
          Expanded(child: _contactsView())
        ],
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton.extended(
              onPressed: _addGroup,
              label: Text("Continue"),
              icon: Icon(Icons.arrow_right_alt_outlined)),
          visible: selected.length > 0 && _groupNameController.text.isNotEmpty),
    );
  }

  Widget _groupNameView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.group_sharp,
              size: 30,
            ),
            radius: 30,
          ),
          SizedBox(width: 5),
          Expanded(
              child: TextField(
            controller: _groupNameController,
            maxLength: maxNameLength,
            onChanged: (txt) {
              setState(() {
                currentNameLength = txt.length;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Group Name',
              counterText: "",
              suffixText:
                  '${currentNameLength.toString()}/${maxNameLength.toString()}',
            ),
          ))
        ],
      ),
    );
  }

  Widget _contactsView() {
    return StreamBuilder<List<ContactChat>>(
        stream: AppData.instance()!.contactsHandler.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            var chats = snapshot.data;
            globalCount = chats != null ? chats.length : 0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select your group members",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.grey)),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: chats!.length,
                      itemBuilder: (context, position) {
                        return InkWell(
                          onTap: () {
                            _toggleSelection(chats[position]);
                          },
                          child: ListTile(
                            title: Text(chats[position].firstName +
                                " " +
                                chats[position].lastName),
                            subtitle: Text("Room: " + chats[position].roomId),
                            leading: AvatarWithBadge(
                              radius: 25,
                              badgeRadius: 8,
                              foregroundImage: NetworkImage(
                                chats[position].avatar ?? "",
                              ),
        showBadge: selected.where((element) => element.id == chats[position].id).length > 0,
                            ),

                          ),
                        );
                      }),
                ),
              ],
            );
          } else {
            return Text("Loading...");
          }
        });
  }

  Widget _selectedView() {
    return Align(
      child: Column(
        children: [
          AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 400),
            height: selected.length > 0 ? 80 : 0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selected.length,
                itemBuilder: (context, index) {
                  return AvatarWithBadge(
                    title: selected[index].firstName,
                    foregroundImage: NetworkImage(selected[index].avatar ?? ""),
                    onTap: () {
                      _toggleSelection(selected[index]);
                    },
                  );
                  return Container();
                }),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: selected.length > 0 ? 1 : 0,
            child: Divider(),
          ),
        ],
      ),
      alignment: Alignment.topCenter,
    );
  }

  _toggleSelection(ContactChat contactChat) {
    bool alreadySelected =
        selected.where((element) => element.id == contactChat.id).isNotEmpty;
    if (alreadySelected) {
      setState(() {
        selected = selected
            .where((element) => element.id != contactChat.id)
            .toList(growable: true);
      });
    } else {
      setState(() {
        selected.add(contactChat);
      });
    }
  }
  _addGroup(){
    ChatApp.instance()!.mucHandler.createGroup(name: _groupNameController.text, members: selected.map((e) => e.id).toList());
    Navigator.pop(context);
  }
}
