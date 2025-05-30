// lib/common/widgets/custom_menu_button.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMenuButton extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  final String? customIconPath;

  const CustomMenuButton({
    Key? key,
    this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    this.customIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customIconPath != null
                ? Image.asset(
                    customIconPath!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  )
                : Icon(icon, size: 42, color: color),
            const SizedBox(height: 12),
            Text(
              title.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}