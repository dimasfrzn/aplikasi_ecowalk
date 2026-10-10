import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';
import 'verification_phone_screen.dart';
import '../models/verification_flow.dart';
import 'forgot_password_phone_screen.dart';
import 'new_password_screen.dart';

class VerificationEmailScreen extends StatefulWidget {
  final String email;
  final String phoneNumber;
  final VerificationFlow flow;

  const VerificationEmailScreen({
    super.key,
    this.email = 'contohsample@gmail.com',
    this.phoneNumber = '+6212371923719238',
    this.flow = VerificationFlow.register,
  });

  @override
  State<VerificationEmailScreen> createState() =>
      _VerificationEmailScreenState();
}

class _VerificationEmailScreenState extends State<VerificationEmailScreen> {
  // Kode demo (belum ada email / database sungguhan)
  static const String _demoCode = '1234';

  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  // ===== ALERT: SnackBar =====
  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? Colors.red.shade700 : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }

  // ===== ALERT: AlertDialog (berhasil) =====
  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(
          Icons.check_circle,
          color: AppColors.primary,
          size: 56,
        ),
        title: Text(
          'Verifikasi Berhasil',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Text(
          widget.flow == VerificationFlow.register
              ? 'Email kamu telah terverifikasi. Silakan masuk ke akunmu.'
              : 'Email kamu telah terverifikasi. Silakan buat kata sandi baru.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearInputs() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
  }

  Future<void> _onSubmit() async {
    if (_code.length < 4) {
      _showSnack('Masukkan 4 digit kode verifikasi', isError: true);
      return;
    }

    if (_code != _demoCode) {
      _showSnack('Kode verifikasi salah. Silakan coba lagi.', isError: true);
      _clearInputs();
      return;
    }

    FocusScope.of(context).unfocus();
    await _showSuccessDialog();
    if (!mounted) return;
        if (widget.flow == VerificationFlow.register) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }   else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
      );
    }
  }

  void _onResend() {
    _clearInputs();
    _showSnack('Kode verifikasi baru telah dikirim ke ${widget.email}');
  }

  void _switchToPhone() {
    if (widget.flow == VerificationFlow.register) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerificationPhoneScreen(
            phoneNumber: widget.phoneNumber,
            email: widget.email,
          ),
        ),
      );
    } else {
      // Alur lupa kata sandi: wajib verifikasi ulang lewat no. hp
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ForgotPasswordPhoneScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header diagonal + logo
            SizedBox(
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
                    child: Center(
                      child: Image.asset(
                        'lib/assets/images/logo_hijau.png',
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  // Judul
                  Row(
                    children: [
                      const Icon(Icons.check, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'VERIFIKASI',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Petunjuk
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(Icons.smartphone, size: 36),
                          Positioned(
                            right: -6,
                            bottom: -4,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.chat_bubble,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: GoogleFonts.inter(fontSize: 13),
                            children: [
                              const TextSpan(
                                text:
                                    'Periksa dan ketik kode verifikasi yang telah dikirimkan ke ',
                              ),
                              TextSpan(
                                text: widget.email,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Kotak kode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, _otpBox),
                  ),
                  const SizedBox(height: 32),

                  // Ganti metode
                  InkWell(
                    onTap: _switchToPhone,
                    child: Text(
                      'Verifikasi menggunakan No. Hp',
                      style: GoogleFonts.inter(
                        color: AppColors.link,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol kirim
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'KIRIM',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Kirim ulang
                  Center(
                    child: InkWell(
                      onTap: _onResend,
                      child: Text(
                        'Kirim Ulang Kode',
                        style: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 78,
      height: 78,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        autofocus: index == 0,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF9F9F9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.fieldBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.fieldBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isNotEmpty && index == 3) {
            FocusScope.of(context).unfocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

// Potongan diagonal untuk background header
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.44)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}