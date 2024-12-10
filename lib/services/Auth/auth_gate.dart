import 'package:deliver/pages/home_page.dart';
import 'package:deliver/pages/login_page.dart';
import 'package:deliver/services/Auth/login_or_regsiter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
        if(snapshot.hasData)
        {
          return const HomePage();
        }else{
          return const LoginOrRegsiter();
        }
      }),
    );
  }
}