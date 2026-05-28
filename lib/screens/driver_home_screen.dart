import 'package:flutter/material.dart';
import 'tracking_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'attendance_screen.dart';
import 'package:geocoding/geocoding.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() =>
      _DriverHomeScreenState();
}


class _DriverHomeScreenState extends State<DriverHomeScreen> {

  int currentIndex = 0;

  bool isOnline = true;

  String selectedLocation =
      "Fetching location...";

  void startLiveTracking() {
    Geolocator.getPositionStream(

      locationSettings: const LocationSettings(

        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),

    ).listen((Position position) async {
      await FirebaseFirestore.instance
          .collection('driverLocation')
          .doc('driver1')
          .set({

        'lat': position.latitude,
        'lng': position.longitude,
      });
    });
  }

  @override
  void initState() {
    super.initState();

    startLiveTracking();

    getLiveAddress();
  }

  Future<void> updateLocation() async {
    await FirebaseFirestore.instance
        .collection('driverLocation')
        .doc('driver1')
        .set({

      'lat': 28.6139,
      'lng': 77.2090,
    });

    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Location Updated",
          ),
        ),
      );
    }
  }

  Future<void> getLiveAddress() async {
    Position position =
    await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    setState(() {
      selectedLocation =
      "${place.locality}, ${place.administrativeArea}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(

        child: Column(

          children: [

            UserAccountsDrawerHeader(

              accountName:
              const Text("Rajesh Kumar"),

              accountEmail:
              const Text("driver@safevan.com"),

              currentAccountPicture:
              const CircleAvatar(

                backgroundColor: Colors.white,

                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
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
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),

      backgroundColor: Colors.white,

      floatingActionButton:
      FloatingActionButton(

        backgroundColor: Colors.black,

        onPressed: () async {
          await updateLocation();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const ChatScreen(),
            ),
          );
        },

        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),

      bottomNavigationBar:
      Container(

        height: 72,

        decoration: const BoxDecoration(

          color: Colors.black,

          borderRadius:
          BorderRadius.only(
            topLeft:
            Radius.circular(22),
            topRight:
            Radius.circular(22),
          ),
        ),

        child: BottomNavigationBar(

          currentIndex:
          currentIndex,

          backgroundColor:
          Colors.transparent,

          elevation: 0,

          type:
          BottomNavigationBarType
              .fixed,

          selectedItemColor:
          Colors.yellow,

          unselectedItemColor:
          Colors.white70,

          onTap: (index) {
            setState(() {
              currentIndex =
                  index;
            });

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const TrackingScreen(),
                ),
              );
            }

            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const NotificationsScreen(),
                ),
              );
            }

            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const ProfileScreen(),
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
              icon:
              Icon(Icons.location_on),
              label: "Tracking",
            ),

            BottomNavigationBarItem(
              icon:
              Icon(Icons.notifications),
              label: "Alerts",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(
              18),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [

            /// TOP BAR
            Row(

            mainAxisAlignment:
            MainAxisAlignment
            .spaceBetween,

            children: [

          /// LOCATION
          Row(

          children: [

          const Icon(
          Icons.location_on,
            color:
            Colors.black,
            size: 20,
          ),

          const SizedBox(
              width: 5),
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
    GestureDetector(

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const ProfileScreen(),
          ),
        );
      },

    child: Container(

    height: 45,
    width: 45,

    decoration:
    BoxDecoration(

    color:
    Colors.black,

    borderRadius:
    BorderRadius
        .circular(
    14),
    ),

    child:
    const Icon(
    Icons.person,
    color:
    Colors.white,
    ),
    ),
    ),
    ],
    ),

    const SizedBox(
    height: 20),

    /// GREETING
    const Text(

    "Driver Dashboard",

    style: TextStyle(
    color: Colors.grey,
    fontSize: 14,
    ),
    ),

    const SizedBox(
    height: 5),

    const Text(

    "Rajesh Kumar",

    style: TextStyle(
    fontSize: 26,
    fontWeight:
    FontWeight.bold,
    ),
    ),

    const SizedBox(
    height: 22),

    /// STATUS CARD
    Container(

    padding:
    const EdgeInsets
        .all(18),

    decoration:
    BoxDecoration(

    color: Colors.black,

    borderRadius:
    BorderRadius
        .circular(
    24),
    ),

    child: Column(

    children: [

    Row(

    mainAxisAlignment:
    MainAxisAlignment
        .spaceBetween,

    children: [

    const Text(

    "Driver Status",

    style:
    TextStyle(
    color: Colors
        .white70,
    fontSize:
    14,
    ),
    ),

    Switch(

    value:
    isOnline,

    activeThumbColor:
    Colors
        .yellow,

    onChanged:
    (value) {

    setState(() {

    isOnline =
    value;
    });
    },
    ),
    ],
    ),

    const SizedBox(
    height: 10),

    Align(

    alignment:
    Alignment
        .centerLeft,

    child: Text(

    isOnline
    ? "Online"
        : "Offline",

    style:
    TextStyle(

    color: isOnline
    ? Colors
        .greenAccent
        : Colors
        .redAccent,

    fontSize:
    28,

    fontWeight:
    FontWeight
        .bold,
    ),
    ),
    ),

    const SizedBox(
    height: 18),

    Container(

    height: 140,

    decoration:
    BoxDecoration(

    color: Colors
        .white10,

    borderRadius:
    BorderRadius
        .circular(
    20),
    ),

    child:
    const Center(

    child: Text(

    "Live Route Map",

    style:
    TextStyle(
    color: Colors
        .white54,
    ),
    ),
    ),
    ),

    const SizedBox(
    height: 18),

    Row(

    mainAxisAlignment:
    MainAxisAlignment
        .spaceBetween,

    children: [

    Column(

    crossAxisAlignment:
    CrossAxisAlignment
        .start,

    children:
    const [

    Text(

    "Today's Trips",

    style:
    TextStyle(
    color: Colors
        .white54,
    fontSize:
    12,
    ),
    ),

    SizedBox(
    height:
    4),

    Text(

    "12 Trips",

    style:
    TextStyle(
    color: Colors
        .white,
    fontWeight:
    FontWeight
        .bold,
    ),
    ),
    ],
    ),

    Column(

    crossAxisAlignment:
    CrossAxisAlignment
        .end,

    children:
    const [

    Text(

    "Passengers",

    style:
    TextStyle(
    color: Colors
        .white54,
    fontSize:
    12,
    ),
    ),

    SizedBox(
    height:
    4),

    Text(

    "34 Students",

    style:
    TextStyle(
    color: Colors
        .yellow,
    fontWeight:
    FontWeight
        .bold,
    ),
    ),
    ],
    ),
    ],
    ),
    ],
    ),
    ),

    const SizedBox(
    height: 28),

    /// SERVICES
    const Text(

    "Driver Services",

    style: TextStyle(
    fontSize: 22,
    fontWeight:
    FontWeight.bold,
    ),
    ),

    const SizedBox(
    height: 18),

    GridView.count(

    crossAxisCount: 2,

    shrinkWrap: true,

    physics:
    const NeverScrollableScrollPhysics(),

    crossAxisSpacing:
    15,

    mainAxisSpacing:
    15,

    childAspectRatio:
    1.15,

    children: [

    serviceCard(
    icon:
    Icons.location_on,
    title:
    "Start Trip",
    color: Colors
        .orange.shade100,
    iconColor:
    Colors.orange,
    ),

    serviceCard(
    icon: Icons.people,
    title:
    "Passengers",
    color: Colors
        .blue.shade100,
    iconColor:
    Colors.blue,
    ),

    serviceCard(
    icon: Icons
        .notifications,
    title: "Alerts",
    color: Colors
        .red.shade100,
    iconColor:
    Colors.red,
    ),

    serviceCard(
    icon: Icons.route,
    title: "Tracking",
    color: Colors
        .green.shade100,
    iconColor:
    Colors.green,
    ),
    ],
    ),

    const SizedBox(
    height: 28),

    /// RECENT ACTIVITY
    const Text(

    "Recent Activity",

    style: TextStyle(
    fontSize: 22,
    fontWeight:
    FontWeight.bold,
    ),
    ),

    const SizedBox(
    height: 18),

    activityTile(
    "Trip started successfully",
    "Today • 7:10 AM",
    ),

    activityTile(
    "Students picked up",
    "Today • 7:35 AM",
    ),

    activityTile(
    "Payment received",
    "Yesterday • 5:40 PM",
    ),

    const SizedBox(
    height: 30),
    ],
    ),
    ),
    )
    ,
    );
  }

  Widget serviceCard({

    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,

  }) {
    return GestureDetector(

      onTap: () async {

        // START TRIP
        if (title == "Start Trip") {

          startLiveTracking();

          await updateLocation();

          ScaffoldMessenger.of(context)
              .showSnackBar(

            const SnackBar(
              content: Text(
                "Trip Started Successfully",
              ),
            ),
          );
        }

        // PASSENGERS
        else if (title == "Passengers") {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
              const AttendanceScreen(),
            ),
          );
        }

        // ALERTS
        else if (title == "Alerts") {

          await FirebaseFirestore.instance
              .collection('notifications')
              .add({

            'title': 'Emergency Alert',
            'time': 'Driver sent emergency alert',
          });

          ScaffoldMessenger.of(context)
              .showSnackBar(

            const SnackBar(
              content: Text(
                "Emergency Alert Sent",
              ),
            ),
          );
        }

        // TRACKING
        else if (title == "Tracking") {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
              const TrackingScreen(),
            ),
          );
        }
      },

    child: Container(

    padding:
    const EdgeInsets.all(18),

    decoration: BoxDecoration(

    color:
    Colors.grey.shade100,

    borderRadius:
    BorderRadius.circular(
    20),
    ),

    child: Column(

    crossAxisAlignment:
    CrossAxisAlignment
        .start,

    children: [

    Container(

    padding:
    const EdgeInsets
        .all(12),

    decoration:
    BoxDecoration(

    color: color,

    shape:
    BoxShape.circle,
    ),

    child: Icon(
    icon,
    color: iconColor,
    ),
    ),

    const Spacer(),

    Text(

    title,

    style:
    const TextStyle(
    fontWeight:
    FontWeight.bold,
    fontSize: 16,
    ),
    ),
    ]
    ,
    )
    ,
    )
    ,
    );
  }

  Widget activityTile(String title,
      String subtitle,) {
    return Container(

      margin:
      const EdgeInsets.only(
          bottom: 14),

      padding:
      const EdgeInsets.all(15),

      decoration: BoxDecoration(

        color:
        Colors.grey.shade100,

        borderRadius:
        BorderRadius.circular(
            18),
      ),

      child: Row(

        children: [

          Container(

            padding:
            const EdgeInsets
                .all(10),

            decoration:
            const BoxDecoration(

              color: Colors.black,

              shape: BoxShape.circle,
            ),

            child: const Icon(

              Icons.notifications,

              color: Colors.yellow,

              size: 18,
            ),
          ),

          const SizedBox(
              width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [

                Text(

                  title,

                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight
                        .w600,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(

                  subtitle,

                  style:
                  const TextStyle(
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