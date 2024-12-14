import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deliver/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
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
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
                ),
              ),
              
            ));
  }

  @override
  Widget build(BuildContext context) {
    String username = user.email!.split('@').first;

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
              if (snpshot.hasData) {
                // Check if the document data exists
                if (snpshot.data!.docs.isNotEmpty) {
                  final userData =
                      snpshot.data!.docs.first.data() as Map<String, dynamic>;
                  return ListView(
                    children: [
                      const SizedBox(height: 25),
                      const Icon(
                        Icons.person,
                        size: 100,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user.email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          "My Details",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
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
                    ],
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
