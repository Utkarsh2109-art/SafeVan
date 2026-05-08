import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class RoleSelector extends StatefulWidget {
  final Function(String role)? onRoleChanged;
  const RoleSelector({super.key, this.onRoleChanged});

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  String _selected = 'Parent';
  final List<Map<String, String>> _roles = [
    {'label': 'Parent', 'emoji': '👨‍👩‍👧'},
    {'label': 'Driver', 'emoji': '🚌'},
    {'label': 'Admin', 'emoji': '🏫'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _roles.map((role) {
        final isActive = _selected == role['label'];
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _selected = role['label']!);
              widget.onRoleChanged?.call(role['label']!);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                right: role == _roles.last ? 0 : 6,
              ),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryLight : AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Text(role['emoji']!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(
                    role['label']!,
                    style: GoogleFonts.nunito(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: isActive ? AppColors.textMuted : AppColors.hint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
