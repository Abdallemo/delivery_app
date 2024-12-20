// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/pages/location_page.dart';
import 'package:deliver/services/Auth/auth_gate.dart';
import 'package:deliver/services/Auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deliver/components/text_box.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  // late final AnimationController _controller;
  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text(
                "Edit $field",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                //cancel btn >:
                TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )),

                //save btn :D
                TextButton(
                    onPressed: () => {Navigator.of(context).pop(context)},
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ))
              ],
            ));

    if (newValue.trim().isNotEmpty) {
      // Fetch dc id
      final snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Profile")
          .get();

      if (snapshot.docs.isNotEmpty) {
        //getters
        final profileDocId = snapshot.docs.first.id;

        // Update the field in the Profile document
        FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .collection("Profile")
            .doc(profileDocId)
            .update({field: newValue});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PROFILE'),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(user.uid)
                .collection("Profile")
                .snapshots(),
            builder: (context, snpshot) {
              if (snpshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator()); // Loading indicator
              }
              if (snpshot.hasData) {
                if (snpshot.data!.docs.isNotEmpty) {
                  final userData =
                      snpshot.data!.docs.first.data() as Map<String, dynamic>;
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Lottie.asset('assets/animations/Profile.json',
                              width: 200),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.email!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'assets/flattIcon/delete.png',
                                  width: 24.0,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Confirm Deletion"),
                                        content: Text(
                                            "Are you sure you want to delete this account?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              TextEditingController
                                                  passwordController =
                                                  TextEditingController();
                                              Navigator.pop(
                                                  context); // Close the first dialog

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Confirm Your Password"),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Please enter your password to permanently delete your account.",
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        TextField(
                                                          controller:
                                                              passwordController,
                                                          obscureText: true,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Password',
                                                            hintText:
                                                                'Enter Your Password',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context), // Close dialog
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                        onPressed: () async {
                                                          try {
                                                            await AuthService()
                                                                .reauthenticateAndDelete(
                                                              user.email!,
                                                              passwordController
                                                                  .text,
                                                            );

                                                            Navigator.pop(
                                                                context); // Close password dialog
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AuthGate(),
                                                              ),
                                                            );
                                                          } catch (e) {
                                                            // Handle error (e.g., wrong password)
                                                            Navigator.pop(
                                                                context); // Close password dialog
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "Error"),
                                                                  content: Text(
                                                                      e.toString()),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Delete"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              "My Details",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyTextBox(
                            text: userData['username'] ?? 'No username set',
                            sectionName: 'username',
                            onPressed: () => editField('username'),
                          ),
                          MyTextBox(
                            text: userData['bio'] ?? 'No bio set',
                            sectionName: 'bio',
                            onPressed: () => editField('bio'),
                          ),
                          MyTextBox(
                            text: userData['location'] ?? 'No location set',
                            sectionName: 'location',
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationPage())),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Document does not exist or is empty."),
                  );
                }
              } else if (snpshot.hasError) {
                return Center(
                  child: Text("Error: ${snpshot.error}"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
