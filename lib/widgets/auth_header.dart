import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Header diagonal abu-hijau + logo, dengan judul opsional di bawah logo.
class AuthHeader extends StatelessWidget {
  final String? title;

  const AuthHeader({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 262,
      child: Stack(
        children: [
          ClipPath(
            clipper: _HeaderClipper(),
            child: Container(
              height: 262,
              color: const Color(0xFFD9E5E2),
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/images/logo_hijau.png',
                  width: 240,
                  fit: BoxFit.contain,
                ),
                if (title != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    title!,
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.44)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}