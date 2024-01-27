import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade900,
      child: Column(
        children: [
          // logo
           DrawerHeader(
              child: Center(
            child: Icon(
              CupertinoIcons.music_note,
              size: 40,
              color: Colors.grey.shade200,
            ),
          )),

          //home title
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: ListTile(
              title:  Text("H O M E",
              style: TextStyle(color: Colors.grey.shade300),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.grey.shade300,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),

          //settings
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0),
            child: ListTile(
              title: Text("S E T T I N G",
              style: TextStyle(color: Colors.grey.shade300)
              ),
              leading: Icon(
                Icons.settings,
                color: Colors.grey.shade300,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
