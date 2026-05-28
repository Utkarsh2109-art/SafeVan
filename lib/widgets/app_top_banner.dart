import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'safevan_logo.dart';
import 'app_colors.dart';

class AppTopBanner extends StatelessWidget {
  const AppTopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          const SafeVanLogo(size: 82),
          const SizedBox(height: 12),
          Text(
            'SafeVan',
            style: GoogleFonts.nunito(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Smart Routes · Trusted Drivers · Safe Journeys',
            style: GoogleFonts.nunito(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
