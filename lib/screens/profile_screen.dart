import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _name = 'KAYI NYAP NYAP';
  static const String _email = 'kayimail@gmail.com';

  void _comingSoon(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text('Halaman $label belum tersedia'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }

  // ===== ALERT: AlertDialog konfirmasi keluar =====
  Future<void> _confirmLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(Icons.logout, color: AppColors.primary, size: 44),
        title: Text(
          'Keluar',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Apakah kamu yakin ingin keluar dari akun?',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Batal',
              style: GoogleFonts.inter(
                color: AppColors.iconGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Keluar',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <_MenuItem>[
      _MenuItem(Icons.settings_outlined, 'Pengaturan',
          () => _comingSoon(context, 'Pengaturan')),
      _MenuItem(Icons.edit_outlined, 'Edit Profil',
          () => _comingSoon(context, 'Edit Profil')),
      _MenuItem(Icons.lock_outline, 'Kebijakan Privasi',
          () => _comingSoon(context, 'Kebijakan Privasi')),
      _MenuItem(Icons.info_outline, 'Tentang Kami',
          () => _comingSoon(context, 'Tentang Kami')),
      _MenuItem(Icons.article_outlined, 'Ketentuan Layanan',
          () => _comingSoon(context, 'Ketentuan Layanan')),
      _MenuItem(Icons.logout, 'Keluar', () => _confirmLogout(context)),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: _ProfileBottomNav(
          onTap: (label) => _comingSoon(context, label),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header hijau + foto profil
              SizedBox(
                height: 215,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(height: 160, color: AppColors.primary),
                    Positioned(
                      top: 92,
                      child: Container(
                        width: 124,
                        height: 124,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'lib/assets/images/Ellipse_29.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => Container(
                              color: const Color(0xFFE0E0E0),
                              child: const Icon(
                                Icons.person,
                                size: 64,
                                color: AppColors.iconGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Nama + email
              Text(
                _name,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _email,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 24),

              // Daftar menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(items.length, (i) {
                    final item = items[i];
                    return Column(
                      children: [
                        InkWell(
                          onTap: item.onTap,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                Icon(item.icon, size: 24),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.chevron_right, size: 28),
                              ],
                            ),
                          ),
                        ),
                        if (i != items.length - 1)
                          const Divider(height: 1, color: Colors.black26),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _MenuItem(this.icon, this.label, this.onTap);
}

// Bottom nav: 3 menu + tab "Akun" aktif berbentuk lingkaran menonjol
class _ProfileBottomNav extends StatelessWidget {
  final void Function(String label) onTap;

  const _ProfileBottomNav({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _navIcon(Icons.home_outlined, 'Beranda'),
              _navIcon(Icons.verified_user, 'Verifikasi'),
              _navIcon(Icons.chat_bubble, 'Pesan'),

              // Tab Akun (aktif)
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: -38,
                      child: Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      child: Text(
                        'AKUN',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, String label) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(label),
        child: Center(child: Icon(icon, color: Colors.white, size: 28)),
      ),
    );
  }
}