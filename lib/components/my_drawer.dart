import 'package:deliver/components/my_drawer_tile.dart';
import 'package:deliver/pages/delivery_page.dart';
import 'package:deliver/pages/profile_page.dart';
import 'package:deliver/pages/settings_page.dart';
import 'package:deliver/services/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(BuildContext context){
    final authService = AuthService();
    authService.singOut();
    Navigator.pushReplacementNamed(context, '/');

  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Lottie.asset("assets/animations/Animation - 1733839487140.json",width: 155),
            
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(thickness: 0.5,),
          ),
          //home
          MyDrawerTile(
              icon: Image.asset('assets/flattIcon/home.png',width: 24.0,),
              onTap: () => Navigator.pop(context),
              text: "H O M E"),
          //settings
          MyDrawerTile(
              icon: Image.asset('assets/flattIcon/user-icon.png',width: 24.0,),
              onTap: () { Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilePage()));} ,
              text: "P R O F I L E"),

              MyDrawerTile(
              icon: Image.asset('assets/flattIcon/shopping-done.png',width: 24.0,),
              onTap: () { Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const DeliveryPage()));} ,
              text: "MY P U R C H A S E"),


              MyDrawerTile(
              icon: Image.asset('assets/flattIcon/settings.png',width: 24.0,),
              onTap: () { Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsPage()));} ,
              text: "S E T I N G S"),

          Spacer(),
          //logout
          MyDrawerTile(
              icon: Image.asset('assets/flattIcon/logout.png',width: 24.0,), onTap: ()=> logout(context), text: "L O G O U T"),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
