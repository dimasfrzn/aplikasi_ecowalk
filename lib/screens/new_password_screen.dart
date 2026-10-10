import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_header.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Kata sandi baru wajib diisi';
    if (v.length < 8) return 'Kata sandi minimal 8 karakter';
    if (!RegExp(r'[a-zA-Z]').hasMatch(v) || !RegExp(r'[0-9]').hasMatch(v)) {
      return 'Kata sandi harus mengandung huruf dan angka';
    }
    return null;
  }

  String? _validateConfirm(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Konfirmasi kata sandi wajib diisi';
    if (v != _passwordController.text) return 'Konfirmasi kata sandi tidak sama';
    return null;
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
          'Kata Sandi Diubah',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Kata sandi kamu berhasil diubah. Silakan masuk dengan kata sandi baru.',
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

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    await _showSuccessDialog();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
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
                    Text(
                      'Masukan Kata Sandi Baru',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _field(
                      controller: _passwordController,
                      hint: 'Kata Sandi Baru',
                      obscure: _obscurePassword,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),
                    _field(
                      controller: _confirmController,
                      hint: 'Konfirmasi Kata Sandi',
                      obscure: _obscureConfirm,
                      onToggle: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                      validator: _validateConfirm,
                    ),
                    const SizedBox(height: 40),

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
                          'UBAH KATA SANDI',
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

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: GoogleFonts.inter(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          fontStyle: FontStyle.italic,
          color: AppColors.iconGrey,
        ),
        errorStyle: GoogleFonts.inter(fontSize: 11),
        errorMaxLines: 2,
        prefixIcon: const Icon(Icons.lock, color: AppColors.iconGrey),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.iconGrey,
          ),
          onPressed: onToggle,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
        ),
      ),
    );
  }
}