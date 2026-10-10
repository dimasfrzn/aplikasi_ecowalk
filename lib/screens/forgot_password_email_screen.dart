import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_header.dart';
import 'forgot_password_phone_screen.dart';
import '../models/verification_flow.dart';
import 'verification_email_screen.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Alamat email wajib diisi';
    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)*\.[a-zA-Z]{2,}$').hasMatch(v)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // ===== ALERT: AlertDialog (kode terkirim) =====
  Future<void> _showSentDialog(String email) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(
          Icons.mark_email_read,
          color: AppColors.primary,
          size: 52,
        ),
        title: Text(
          'Kode Terkirim',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Text.rich(
          TextSpan(
            style: GoogleFonts.inter(fontSize: 13),
            children: [
              const TextSpan(text: 'Kode verifikasi telah dikirim ke '),
              TextSpan(
                text: email,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(text: '. Silakan periksa email kamu.'),
            ],
          ),
          textAlign: TextAlign.center,
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

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    final email = _emailController.text.trim();
    await _showSentDialog(email);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerificationEmailScreen(
          email: email,
          flow: VerificationFlow.resetPassword,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(title: 'LUPA KATA SANDI'),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Petunjuk
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.notifications_none, size: 26),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Periksa dan masukan alamat Email untuk mendapatkan kode verifikasi',
                            style: GoogleFonts.inter(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Kolom email (gaya garis bawah)
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      style: GoogleFonts.inter(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: 'Alamat Email',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.iconGrey,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        errorStyle: GoogleFonts.inter(fontSize: 11),
                        contentPadding: const EdgeInsets.only(top: 22, bottom: 10),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade700),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red.shade700, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Ganti metode
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPhoneScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Gunakan Nomor Hp',
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
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}