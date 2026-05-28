import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() =>
      _LocationSelectorState();
}

class _LocationSelectorState
    extends State<LocationSelector> {

  String selectedLocation = "Kolkata";

  final List<String> locations = [
    "Kolkata",
    "Delhi",
    "Mumbai",
    "Hyderabad",
    "Bangalore",
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLocation,

          icon: const Icon(Icons.keyboard_arrow_down),

          items: locations.map((location) {

            return DropdownMenuItem(
              value: location,

              child: Text(
                location,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),

          onChanged: (value) {
            setState(() {
              selectedLocation = value!;
            });
          },
        ),
      ),
    );
  }
}