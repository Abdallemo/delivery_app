import 'package:deliver/components/my_drawer_tile.dart';
import 'package:deliver/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Divider(),
          ),
          //home
          MyDrawerTile(
              icon: Icons.home,
              onTap: () => Navigator.pop(context),
              text: "H O M E"),
          //settings
          MyDrawerTile(
              icon: Icons.settings_suggest_outlined,
              onTap: () { Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsPage()));} ,
              text: "S E T I N G S"),
          Spacer(),
          //logout
          MyDrawerTile(
              icon: Icons.logout_rounded, onTap: () {}, text: "L O G O U T"),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
