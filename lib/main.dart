import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const SafeVanApp());
}

class SafeVanApp extends StatelessWidget {

  const SafeVanApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'SafeVan',

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.system,

      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xfff5f7fb),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 0,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.blue,

        unselectedItemColor: Colors.grey,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Tracking",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(18),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    Row(

                      children: [

                        Image.asset(
                          "assets/icons/app_icon.png",
                          height: 42,
                          width: 42,
                        ),

                        const SizedBox(width: 10),

                        const Text(

                          "SafeVan",

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    Container(

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Container(

                  width: double.infinity,

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius: BorderRadius.circular(30),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                      ),
                    ],
                  ),

                  child: Padding(

                    padding: const EdgeInsets.all(22),

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(

                          "Travel safely\nwith school vans",

                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(

                          "Smart routes. Trusted drivers.\nHappy journeys.",

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 22),

                        ClipRRect(

                          borderRadius:
                          BorderRadius.circular(24),

                          child: Image.network(

                            "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1200&auto=format&fit=crop",

                            height: 220,

                            width: double.infinity,

                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Padding(

                    padding: const EdgeInsets.all(18),

                    child: Column(

                      children: [

                        buildInputTile(
                          Icons.location_on,
                          "Pickup Location",
                          "Enter pickup point",
                        ),

                        const Divider(),

                        buildInputTile(
                          Icons.school,
                          "School",
                          "Enter school name",
                        ),

                        const Divider(),

                        buildInputTile(
                          Icons.calendar_month,
                          "Date",
                          "Today",
                        ),

                        const Divider(),

                        buildInputTile(
                          Icons.people,
                          "Passenger",
                          "1 Student",
                        ),

                        const SizedBox(height: 20),

                        SizedBox(

                          width: double.infinity,

                          height: 58,

                          child: ElevatedButton(

                            onPressed: () {},

                            style:
                            ElevatedButton.styleFrom(

                              backgroundColor: Colors.blue,

                              shape: RoundedRectangleBorder(

                                borderRadius:
                                BorderRadius.circular(16),
                              ),
                            ),

                            child: const Text(

                              "Search Vans",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(

                  "Features",

                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                GridView.count(

                  crossAxisCount: 2,

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  mainAxisSpacing: 18,

                  crossAxisSpacing: 18,

                  childAspectRatio: 1.05,

                  children: const [

                    FeatureCard(
                      icon: Icons.gps_fixed,
                      title: "Live Tracking",
                      subtitle: "Track vans in real-time",
                    ),

                    FeatureCard(
                      icon: Icons.verified_user,
                      title: "Safe & Trusted",
                      subtitle: "Verified drivers",
                    ),

                    FeatureCard(
                      icon: Icons.notifications_active,
                      title: "Smart Alerts",
                      subtitle: "Pickup & drop alerts",
                    ),

                    FeatureCard(
                      icon: Icons.payment,
                      title: "Easy Payments",
                      subtitle: "Secure & cashless",
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputTile(
      IconData icon,
      String title,
      String subtitle,
      ) {

    return ListTile(

      contentPadding: EdgeInsets.zero,

      leading: Icon(
        icon,
        color: Colors.blue,
      ),

      title: Text(

        title,

        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Text(subtitle),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {

  final IconData icon;

  final String title;

  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(

              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(

                color: Colors.blue.withOpacity(0.1),

                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: Colors.blue,
                size: 32,
              ),
            ),

            const SizedBox(height: 14),

            Text(

              title,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              subtitle,

              textAlign: TextAlign.center,

              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}