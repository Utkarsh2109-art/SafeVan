// signup_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'parent_home_screen.dart';
import 'driver_home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  final TextEditingController
  nameController =
  TextEditingController();

  final TextEditingController
  emailController =
  TextEditingController();

  final TextEditingController
  passwordController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController childNameController =
  TextEditingController();

  final TextEditingController childClassController =
  TextEditingController();

  final TextEditingController vanNumberController =
  TextEditingController();

  final TextEditingController licenseController =
  TextEditingController();

  final TextEditingController routeController =
  TextEditingController();

  String selectedRole = "Parent";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              IconButton(

                onPressed: () {

                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
              ),

              const SizedBox(height: 20),

              const Text(

                "Create Account 🚀",

                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                "Sign up to continue",

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              /// NAME
              Container(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                decoration: BoxDecoration(

                  color: Colors.grey.shade100,

                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: TextField(

                  controller: nameController,

                  decoration:
                  const InputDecoration(

                    border: InputBorder.none,

                    hintText: "Full Name",

                    icon: Icon(Icons.person),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// EMAIL
              Container(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                decoration: BoxDecoration(

                  color: Colors.grey.shade100,

                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: TextField(

                  controller:
                  emailController,

                  decoration:
                  const InputDecoration(

                    border: InputBorder.none,

                    hintText: "Email",

                    icon: Icon(Icons.email),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// PASSWORD
              Container(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                decoration: BoxDecoration(

                  color: Colors.grey.shade100,

                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: TextField(

                  controller:
                  passwordController,

                  obscureText: true,

                  decoration:
                  const InputDecoration(

                    border: InputBorder.none,

                    hintText: "Password",

                    icon: Icon(Icons.lock),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              if (selectedRole == "Parent") ...[

                const SizedBox(height: 15),

                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),

                const SizedBox(height: 15),

                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: TextField(

                    controller: childNameController,

                    decoration: const InputDecoration(

                      border: InputBorder.none,

                      hintText: "Child Name",

                      icon: Icon(Icons.child_care),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

        Container(

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),

          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(18),
          ),

          child: TextField(

            controller: childClassController,

            decoration: const InputDecoration(

              border: InputBorder.none,

              hintText: "Child Class",

              icon: Icon(Icons.school),

            ),
          ),
        ),
              ],

              if (selectedRole == "Driver") ...[

                const SizedBox(height: 15),

                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: TextField(

                    controller: phoneController,

                    keyboardType: TextInputType.phone,

                    decoration: const InputDecoration(

                      border: InputBorder.none,

                      hintText: "Phone Number",

                      icon: Icon(Icons.phone),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

    Container(

    padding: const EdgeInsets.symmetric(
    horizontal: 18,
    ),

    decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(18),
    ),

    child: TextField(

    controller: vanNumberController,

    decoration: const InputDecoration(

    border: InputBorder.none,

    hintText: "Van Number",

    icon: Icon(Icons.directions_bus),
    ),
    ),
    ),

                const SizedBox(height: 15),

    Container(

    padding: const EdgeInsets.symmetric(
    horizontal: 18,
    ),

    decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(18),
    ),

    child: TextField(

    controller: licenseController,

    decoration: const InputDecoration(

    border: InputBorder.none,

    hintText: "License Number",

    icon: Icon(Icons.badge),
    ),
    ),
    ),

                const SizedBox(height: 15),

    Container(

    padding: const EdgeInsets.symmetric(
    horizontal: 18,
    ),

    decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(18),
    ),

    child: TextField(

    controller: routeController,

    decoration: const InputDecoration(

    border: InputBorder.none,

    hintText: "Route",

    icon: Icon(Icons.route),
    ),
    ),
    ),
              ],

              const Text(

                "Select Role",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              /// ROLE SELECTION
              Row(

                children: [

                  Expanded(

                    child: GestureDetector(

                      onTap: () {

                        setState(() {

                          selectedRole =
                          "Parent";
                        });
                      },

                      child: Container(

                        padding:
                        const EdgeInsets.all(
                            18),

                        decoration: BoxDecoration(

                          color:
                          selectedRole ==
                              "Parent"
                              ? Colors.black
                              : Colors.grey
                              .shade100,

                          borderRadius:
                          BorderRadius.circular(
                              18),
                        ),

                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Text(

                              "Parent",

                              style: TextStyle(

                                color:
                                selectedRole ==
                                    "Parent"
                                    ? Colors.white
                                    : Colors.black,

                                fontSize: 16,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            Icon(

                              Icons
                                  .keyboard_arrow_down,

                              color:
                              selectedRole ==
                                  "Parent"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(

                    child: GestureDetector(

                      onTap: () {

                        setState(() {

                          selectedRole =
                          "Driver";
                        });
                      },

                      child: Container(

                        padding:
                        const EdgeInsets.all(
                            18),

                        decoration: BoxDecoration(

                          color:
                          selectedRole ==
                              "Driver"
                              ? Colors.black
                              : Colors.grey
                              .shade100,

                          borderRadius:
                          BorderRadius.circular(
                              18),
                        ),

                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Text(

                              "Driver",

                              style: TextStyle(

                                color:
                                selectedRole ==
                                    "Driver"
                                    ? Colors.white
                                    : Colors.black,

                                fontSize: 16,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            Icon(

                              Icons
                                  .keyboard_arrow_down,

                              color:
                              selectedRole ==
                                  "Driver"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// SIGNUP BUTTON
              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                    Colors.black,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          18),
                    ),
                  ),

                  onPressed: () async {

                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Please fill all required fields",
                          ),
                        ),
                      );

                      return;
                    }

                    if (selectedRole == "Driver" &&
                        vanNumberController.text.isEmpty) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Enter van number",
                          ),
                        ),
                      );

                      return;
                    }

                    if (selectedRole == "Parent" &&
                        childNameController.text.isEmpty) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Enter child name",
                          ),
                        ),
                      );

                      return;
                    }

                    try {

                      setState(() {
                        isLoading = true;
                      });

                      UserCredential userCredential =

                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(

                        email:
                        emailController.text.trim(),

                        password:
                        passwordController.text.trim(),
                      );

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({

                        'name':
                        nameController.text.trim(),

                        'email':
                        emailController.text.trim(),

                        'role':
                        selectedRole,

                        'phone':
                        phoneController.text.trim(),

                        'vanNumber':
                        selectedRole == "Driver"
                            ? vanNumberController.text.trim()
                            : "",

                        'route':
                        selectedRole == "Driver"
                            ? routeController.text.trim()
                            : "",

                        'licenseNumber':
                        selectedRole == "Driver"
                            ? licenseController.text.trim()
                            : "",

                        'childName':
                        selectedRole == "Parent"
                            ? childNameController.text.trim()
                            : "",

                        'childClass':
                        selectedRole == "Parent"
                            ? childClassController.text.trim()
                            : "",
                      });

                      if (selectedRole == "Parent") {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                            const ParentHomeScreen(),
                          ),
                        );

                      } else {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                            const DriverHomeScreen(),
                          ),
                        );
                      }

                    } catch (e) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(
                          content: Text(
                            e.toString(),
                          ),
                        ),
                      );
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },

                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(

                    "Create Account",

                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// LOGIN
              Row(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  const Text(
                    "Already have an account?",
                  ),

                  TextButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const LoginScreen(),
                        ),
                      );
                    },

                    child: const Text(

                      "Login",

                      style: TextStyle(
                        color: Colors.black,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  ],
              ),
            ],
        ),
      ),
      ),
    );
  }
}