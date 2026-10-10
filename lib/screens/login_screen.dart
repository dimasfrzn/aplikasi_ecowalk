import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'register_screen.dart';
import 'forgot_password_email_screen.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
    // Akun demo (belum ada database)
  static const String _demoUsername = 'ecowalk';
  static const String _demoPassword = 'ecowalk123';

  // ===== ALERT: SnackBar =====
  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }

  void _onLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnack('Nama pengguna dan kata sandi wajib diisi');
      return;
    }
    if (username.toLowerCase() != _demoUsername || password != _demoPassword) {
      _showSnack('Nama pengguna atau kata sandi salah');
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 70),

              // Judul + logo
              Center(
                child: Column(
                  children: [
                    Text(
                      'MASUK',
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Image.asset(
                      'lib/assets/images/logo_hijau.png',
                      width: 240,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),

              // Nama pengguna
              _label('Nama Pengguna'),
              const SizedBox(height: 6),
              TextField(
                controller: _usernameController,
                decoration: _inputDecoration(icon: Icons.person),
              ),
              const SizedBox(height: 16),

              // Kata sandi
              _label('Kata Sandi'),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration(
                  icon: Icons.lock,
                  suffix: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.iconGrey,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol masuk
              SizedBox(
                height: 45,
                child: ElevatedButton(
                 onPressed: _onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'MASUK',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Lupa kata sandi
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgotPasswordEmailScreen()),
                    );
                  },
                  child: Text(
                    'Lupa Kata Sandi?',
                    style: GoogleFonts.inter(
                      color: AppColors.link,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Pemisah "Atau"
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.black26)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Atau',
                      style: GoogleFonts.inter(fontSize: 10),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.black26)),
                ],
              ),
              const SizedBox(height: 32),

              // Tombol Google
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: login dengan Google
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.fieldBg,
                    foregroundColor: Colors.black,
                    elevation: 4,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/images/google.png',
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Lanjutkan dengan Google',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Daftar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tidak punya akun? ',
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      'Daftar disini',
                      style: GoogleFonts.inter(
                        color: AppColors.link,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  InputDecoration _inputDecoration({required IconData icon, Widget? suffix}) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.fieldBorder),
    );
    return InputDecoration(
      filled: true,
      fillColor: AppColors.fieldBg,
      prefixIcon: Icon(icon, color: AppColors.iconGrey),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}