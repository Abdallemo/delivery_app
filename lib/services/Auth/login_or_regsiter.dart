import 'package:deliver/pages/login_page.dart';
import 'package:deliver/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegsiter extends StatefulWidget {
  const LoginOrRegsiter({super.key});

  @override
  State<LoginOrRegsiter> createState() => _LoginOrRegsiterState();
}

class _LoginOrRegsiterState extends State<LoginOrRegsiter> {
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage)
    {
      return LoginPage(onTap: togglePages);
    }else
    {
      return RegisterPage(onTap: togglePages);
    }
  }
}