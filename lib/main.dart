import 'package:deliver/components/cart_provider.dart';
import 'package:deliver/components/my_notification.dart';
import 'package:deliver/firebase_config.dart';
import 'package:deliver/pages/home_page.dart';
import 'package:deliver/pages/on_board_leading.dart';
import 'package:deliver/services/Auth/auth_gate.dart';
import 'package:deliver/Models/resturent.dart';
import 'package:deliver/services/notification/firebase_fcm_api.dart';
import 'package:deliver/themes/theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  await dotenv.load();

  await Supabase.initialize(
      url: 'https://fqvwbnlotawvqjhckexj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxdndibmxvdGF3dnFqaGNrZXhqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MDY4MjUsImV4cCI6MjA1MDE4MjgyNX0.UuMwZ5bjDM71XNq9S4_FmFObvAUJCJ-KufKobYWMvgc');
  await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);
  await FirebaseFcmApi().initNotifications();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (create) => ThemeSwitcher()),
      ChangeNotifierProvider(create: (create) => Resturent()),
      ChangeNotifierProvider(create: (create) => CartProvider()),
    ],
    child: MyApp(showHome: showHome),
  ));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  // const MyApp({super.key});

  // This widget is the root of my app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome ? AuthGate() : OnBoardLeading(),
      theme: Provider.of<ThemeSwitcher>(context).themeData,
      routes: {
        '/Auth': (context) => const AuthGate(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
