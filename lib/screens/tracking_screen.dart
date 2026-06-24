import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  GoogleMapController? mapController;

  LatLng? currentVanLocation;

  String eta = "Calculating...";

  void updateCamera(LatLng location) {

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(

        CameraPosition(
          target: location,
          zoom: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 320,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
        ),

        child:  Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text(
              "Van On The Way",

              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text("Driver: Rajesh Kumar", style: TextStyle(color: Colors.grey)),

            SizedBox(height: 5),

            Text(
              "ETA: $eta",

              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,

        title: const Text(
          "Live Tracking",

          style: TextStyle(color: Colors.white),
        ),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('driverLocation')
            .doc('driver1')
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;

          if (data == null || !data.exists) {
            return const Center(
              child: Text(
                "Driver location not available",

                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final double lat =
          (data.data()?['lat'] ?? 28.6139).toDouble();

          final double lng =
          (data.data()?['lng'] ?? 77.2090).toDouble();

          final LatLng vanLocation = LatLng(lat, lng);

          currentVanLocation = vanLocation;

          eta = "${5 + DateTime.now().second % 6} mins";

          WidgetsBinding.instance.addPostFrameCallback((_) {

            updateCamera(vanLocation);
          });

          return GoogleMap(
            mapType: MapType.normal,

            initialCameraPosition: CameraPosition(
              target: vanLocation,
              zoom: 15,
            ),

            markers: {
              Marker(
                markerId: const MarkerId("van"),

                position: vanLocation,

                infoWindow: const InfoWindow(
                  title: "SafeVan",
                  snippet: "Driver Live Location",
                ),
              ),
            },

            onMapCreated: (controller) {

              mapController = controller;

              updateCamera(vanLocation);
            },
          );
        },
      ),
    );
  }
}
