import 'package:flutter/material.dart';
import 'tracking_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'booking_screen.dart';
import 'chat_screen.dart';
import '../services/payment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  String userName = "";
  String userEmail = "";
  @override
  void initState() {

    super.initState();

    getLiveLocation();

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
  Future<void> getLiveLocation() async {

    FirebaseFirestore.instance
        .collection('driverLocation')
        .doc('driver1')
        .snapshots()
        .listen((snapshot) async {

      print("Firestore Triggered");

      if (snapshot.exists) {

        final data = snapshot.data();

        print(data);

        double lat =
        (data?['lat'] ?? 0).toDouble();

        double lng =
        (data?['lng'] ?? 0).toDouble();

        List<Placemark> placemarks =
        await placemarkFromCoordinates(
          lat,
          lng,
        );

        setState(() {

          selectedLocation =
              placemarks.first.locality ??
                  "Unknown";
        });

        print(selectedLocation);
      }
    });
  }
  int currentIndex = 0;

  String selectedLocation = "Fetching live location...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        child: ListView(

          children: [

            UserAccountsDrawerHeader(

              accountName:
              Text(userName),

              accountEmail:
              Text(userEmail),

              currentAccountPicture:
              const CircleAvatar(

                backgroundColor:
                Colors.white,

                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const ProfileScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),

              onTap: () async {

                await FirebaseAuth.instance
                    .signOut();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ChatScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),

      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.black87,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TrackingScreen(),
                ),
              );
            }

            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookingScreen(),
                ),
              );
            }

            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            }

            if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            }
          },
          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "Track",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.event_seat),
              label: "Booking",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Alerts",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// LOCATION
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 20,
                      ),

                      const SizedBox(width: 5),
                      Text(
                        selectedLocation,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

/// PROFILE
Builder(
builder: (context) {

return GestureDetector(
                    onTap: () {

                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
);
},
),
                ],
              ),

              const SizedBox(height: 20),

              /// GREETING
              const Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                userName,

                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// SEARCH BAR
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search pickup location",
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 15),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              /// LIVE TRACKING CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Van Status",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),

                        Icon(
                          Icons.directions_bus,
                          color: Colors.yellow,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "On The Way",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Live Van Tracking",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: const [

                            Text(
                              "Driver",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Rajesh Kumar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [

                            Text(
                              "ETA",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "${8 + DateTime.now().second % 5} mins",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// SERVICES
              const Text(
                "Services",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.15,
                children: [

                  serviceCard(

                    icon: Icons.location_on,
                    title: "Track Van",

                    color: Colors.orange.withOpacity(0.15),
                    iconColor: Colors.orange,

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TrackingScreen(),
                        ),
                      );
                    },
                  ),

                  serviceCard(

                    icon: Icons.event_seat,
                    title: "Book Seat",

                    color: Colors.blue.withOpacity(0.15),
                    iconColor: Colors.blue,

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookingScreen(),
                        ),
                      );
                    },
                  ),

                  serviceCard(

                    icon: Icons.notifications,
                    title: "Notifications",

                    color: Colors.red.withOpacity(0.15),
                    iconColor: Colors.red,

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const NotificationsScreen(),
                        ),
                      );
                    },
                  ),

                  serviceCard(

                    icon: Icons.payment,
                    title: "Payments",

                    color: Colors.green.withOpacity(0.15),
                    iconColor: Colors.green,

                    onTap: () {

                      final payment = PaymentService();

                      payment.initialize(

                        onSuccess: () {

                          ScaffoldMessenger.of(context).showSnackBar(

                            const SnackBar(
                              content: Text("Payment Successful"),
                            ),
                          );
                        },
                      );

                      payment.openCheckout();
                    },
                  ),
                ],
              ),


              const SizedBox(height: 28),

              /// RECENT ACTIVITY
              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              activityTile(
                "Van reached pickup point",
                "Today • 7:40 AM",
              ),

              activityTile(
                "Seat booking confirmed",
                "Yesterday • 6:10 PM",
              ),

              activityTile(
                "Pickup reminder notification",
                "Yesterday • 7:00 AM",
              ),

              const SizedBox(height: 30),
            ],
          ),
      ),
    ),
    );
  }

  Widget serviceCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: iconColor,
              ),
            ),

            const Spacer(),

            Text(
              title,

              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activityTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.yellow,
              size: 18,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}