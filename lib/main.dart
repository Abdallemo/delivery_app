import 'package:deliver/Auth/login_or_regsiter.dart';
import 'package:deliver/Models/resturent.dart';
import 'package:deliver/themes/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()  {
 
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (create) => ThemeSwitcher()),
      ChangeNotifierProvider(create: (create) => Resturent()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of my app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegsiter(),
      theme: Provider.of<ThemeSwitcher>(context).themeData,
    );
  }
}
