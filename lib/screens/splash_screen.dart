// splash_screen.dart

import 'package:flutter/material.dart';

import 'login_screen.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    goToNextScreen();
  }

  void goToNextScreen() async {

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            /// LOCATION ICON
            Container(

              height: 120,
              width: 120,

              decoration: BoxDecoration(

                color: Colors.yellow,

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: const Icon(

                Icons.location_on,

                color: Colors.black,

                size: 70,
              ),
            ),

            const SizedBox(height: 35),

            /// APP NAME
            const Text(

              "SafeVan",

              style: TextStyle(

                color: Colors.white,

                fontSize: 42,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// SUBTITLE
            Text(

              "Track Your Child Live",

              style: TextStyle(

                color:
                Colors.white.withOpacity(
                    0.9),

                fontSize: 22,

                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              "Monitor in real-time",

              style: TextStyle(

                color:
                Colors.white.withOpacity(
                    0.6),

                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            /// LOADING
            const CircularProgressIndicator(

              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}