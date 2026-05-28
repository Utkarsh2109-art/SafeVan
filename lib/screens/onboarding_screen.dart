import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPage(Icons.location_on, "Track Your Child Live", "Monitor in real-time"),
          _buildPage(Icons.notifications, "Smart Safety Alerts", "Instant notifications"),
          _buildPage(Icons.support_agent, "Safe & Connected", "Stay in touch", isLast: true, context: context),
        ],
      ),
    );
  }

  Widget _buildPage(IconData icon, String title, String subtitle, {bool isLast = false, BuildContext? context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 100, color: Colors.amber),
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(subtitle),
        if (isLast) ElevatedButton(onPressed: () => Navigator.pushReplacement(context!, MaterialPageRoute(builder: (_) => const LoginScreen())), child: const Text("Get Started"))
      ],
    );
  }
}