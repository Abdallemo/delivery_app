// ignore_for_file: use_build_context_synchronously

import 'package:deliver/components/my_button.dart';
import 'package:deliver/components/my_text_field.dart';
import 'package:deliver/services/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  void login() async {
    //
    final _authService = AuthService();

    try {
      await _authService.signInWithEmailPassword(
          emailcontroller.text, passwordcontroller.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo will but here if found lol
                Lottie.asset("assets/animations/Animation - 1734462434864.json",
                    width: 310),
                const SizedBox(
                  height: 35,
                ),
                //message name
                Text(
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    "Door Dash Fast Delivery"),
                const SizedBox(
                  height: 55,
                ),
                //Email Text
                MyTextField(
                    controller: emailcontroller,
                    hintText: "Email",
                    obscureText: false),

                const SizedBox(height: 10),
                //Password Text
                MyTextField(
                    controller: passwordcontroller,
                    hintText: "Password",
                    obscureText: true),
                const SizedBox(height: 50),

                //sign in button
                MyButton(text: "Sign in", onTap: login),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Resister now",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                //google sign in btn
                Row(
                  children: [
                    // Left Line
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 1.9, // Thickness of the line
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    // Text
                    Text(
                      'Or Sign In With',
                      style: TextStyle(color: Colors.grey),
                    ),
                    // Right Line
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 1.9, // Thickness of the line
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: ()=>AuthService().signInWithGoogle(),
                  borderRadius: BorderRadius.circular(
                      16), // Ripple effect rounded corners
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Image.asset(
                      'assets/flattIcon/google.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                )

                //not signed in if so register
              ],
            ),
          ),
        ),
      ),
    );
  }
}
