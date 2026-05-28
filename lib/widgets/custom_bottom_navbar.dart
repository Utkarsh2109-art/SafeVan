import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.all(18),

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      decoration: BoxDecoration(

        color: Colors.black,

        borderRadius:
        BorderRadius.circular(30),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
          ),
        ],
      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceAround,

        children: [

          navItem(
            icon: Icons.home_rounded,
            index: 0,
            label: "Home",
          ),

          navItem(
            icon: Icons.location_on_rounded,
            index: 1,
            label: "Track",
          ),

          navItem(
            icon: Icons.notifications_rounded,
            index: 2,
            label: "Alerts",
          ),

          navItem(
            icon: Icons.person_rounded,
            index: 3,
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required int index,
    required String label,
  }) {

    final bool isSelected =
        currentIndex == index;

    return GestureDetector(

      onTap: () => onTap(index),

      child: AnimatedContainer(

        duration: const Duration(
          milliseconds: 250,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),

        decoration: BoxDecoration(

          color: isSelected
              ? Colors.yellow
              : Colors.transparent,

          borderRadius:
          BorderRadius.circular(20),
        ),

        child: Row(

          children: [

            Icon(
              icon,

              color: isSelected
                  ? Colors.black
                  : Colors.white70,
            ),

            if (isSelected)
              const SizedBox(width: 8),

            if (isSelected)

              Text(
                label,

                style: const TextStyle(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}