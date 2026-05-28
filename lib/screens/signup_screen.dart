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