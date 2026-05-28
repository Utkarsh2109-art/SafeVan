import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class AuthPage extends StatelessWidget {

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: SingleChildScrollView(
            child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              /// LOGO
              Row(

                children: [

                  Container(

                    padding:
                    const EdgeInsets.all(16),

                    decoration: BoxDecoration(

                      color: Colors.yellow,

                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),

                    child: const Icon(

                      Icons.directions_bus,

                      color: Colors.black,

                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(

                        "SafeVan",

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 34,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(

                        "School Van Tracking",

                        style: TextStyle(

                          color: Colors.grey,

                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              /// IMAGE
              Center(

                child: Container(

                  height: 230,
                  width: 230,

                  decoration: BoxDecoration(

                    color: Colors.yellow
                        .withOpacity(0.1),

                    borderRadius:
                    BorderRadius.circular(
                        40),
                  ),

                  child: const Icon(

                    Icons.location_on,

                    color: Colors.yellow,

                    size: 120,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              /// TITLE
              const Text(

                "Track Your Child\nLive & Safely",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 40,

                  fontWeight: FontWeight.bold,

                  height: 1.2,
                ),
              ),

              const SizedBox(height: 16),

              const Text(

                "Real-time van tracking, alerts, booking and notifications for parents and drivers.",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 16,

                  height: 1.5,
                ),
              ),

              const SizedBox(height: 50),

              /// LOGIN BUTTON
              SizedBox(

                width: double.infinity,
                height: 60,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                    Colors.yellow,

                    foregroundColor:
                    Colors.black,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          18),
                    ),
                  ),

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

                      fontSize: 18,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// SIGNUP BUTTON
              SizedBox(

                width: double.infinity,
                height: 60,

                child: OutlinedButton(

                  style: OutlinedButton.styleFrom(

                    side: const BorderSide(
                      color: Colors.yellow,
                    ),

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          18),
                    ),
                  ),

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                        const SignupScreen(),
                      ),
                    );
                  },

                  child: const Text(

                    "Create Account",

                    style: TextStyle(

                      color: Colors.yellow,

                      fontSize: 18,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      ),
    );
  }
}