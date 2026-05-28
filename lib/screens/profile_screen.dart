import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  String userName = "";
  String userEmail = "";

  @override
  void initState() {

    super.initState();

    loadUserData();
  }

  Future<void> loadUserData() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user != null) {

      final doc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {

        setState(() {

          userName =
          doc['name'];

          userEmail =
          doc['email'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              userName,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              userEmail,

              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const Text(
              "Van Number: Van 01",
            ),

            const SizedBox(height: 10),

            const Text(
              "Phone: +91 9876543210",
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () async {

                  await FirebaseAuth.instance
                      .signOut();

                  Navigator.pop(context);
                },

                child: const Text(
                  "Logout",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}