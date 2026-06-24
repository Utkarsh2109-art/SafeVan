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

  String phone = "";
  String childName = "";
  String childClass = "";
  String vanNumber = "";
  String licenseNumber = "";
  String route = "";
  String role = "";

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

          phone =
              doc['phone'] ?? "";

          childName =
              doc['childName'] ?? "";

          childClass =
              doc['childClass'] ?? "";

          vanNumber =
              doc['vanNumber'] ?? "";

          licenseNumber =
              doc['licenseNumber'] ?? "";

          route =
              doc['route'] ?? "";

          role =
              doc['role'] ?? "";

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
        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Container(

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius: BorderRadius.circular(24),

            boxShadow: [

              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
              ),
            ],
          ),

          child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Container(

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
              ),

              child: const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,

                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 45,
                ),
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

            const SizedBox(height: 12),

            Text(
                role == "Driver"
                    ? "Van Number: $vanNumber"
                    : "Child Name: $childName"
            ),

            const SizedBox(height: 12),

            Text(
                "Phone: $phone",
            ),
            const SizedBox(height: 10),

            Text(
              role == "Driver"
                  ? "Route: $route"
                  : "Class: $childClass",
            ),
            const SizedBox(height: 10),

            if (role == "Driver")
              Text(
                "License: $licenseNumber",
              ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.black,

                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                onPressed: () async {

                  await FirebaseAuth.instance
                      .signOut();

                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),

                label: const Text(

                  "Logout",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}