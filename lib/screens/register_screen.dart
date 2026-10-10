import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'verification_phone_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agree = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // ===== VALIDATOR =====

  String? _validateUsername(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Nama pengguna wajib diisi';
    if (v.length < 3) return 'Nama pengguna minimal 3 karakter';
    if (v.length > 20) return 'Nama pengguna maksimal 20 karakter';
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(v)) {
      return 'Hanya huruf, angka, titik, dan underscore (tanpa spasi)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email wajib diisi';
    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)*\.[a-zA-Z]{2,}$').hasMatch(v)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Nomor HP wajib diisi';
    // Format Indonesia: 08xx..., 628xx..., atau +628xx... (10-13 digit)
    if (!RegExp(r'^(\+62|62|0)8[0-9]{8,11}$').hasMatch(v)) {
      return 'Nomor HP tidak valid (contoh: 081234567890)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Kata sandi wajib diisi';
    if (v.length < 8) return 'Kata sandi minimal 8 karakter';
    if (!RegExp(r'[a-zA-Z]').hasMatch(v) || !RegExp(r'[0-9]').hasMatch(v)) {
      return 'Kata sandi harus mengandung huruf dan angka';
    }
    return null;
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setujui persyaratan dan privasi pengguna terlebih dahulu!'),
        ),
      );
      return;
    }
    // TODO: lanjut ke halaman Verifikasi
        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerificationPhoneScreen(
          phoneNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),

                // Judul + logo
                Center(
                  child: Column(
                    children: [
                      Text(
                        'BUAT AKUN',
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
                const SizedBox(height: 40),

                _field(
                  controller: _usernameController,
                  hint: 'Nama Pengguna',
                  icon: Icons.person,
                  validator: _validateUsername,
                ),
                const SizedBox(height: 22),
                _field(
                  controller: _emailController,
                  hint: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 22),
                _field(
                  controller: _phoneController,
                  hint: 'Nomor Hp',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                ),
                const SizedBox(height: 22),
                _field(
                  controller: _passwordController,
                  hint: 'Kata Sandi',
                  icon: Icons.lock,
                  obscure: _obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 22),
                _field(
                  controller: _confirmController,
                  hint: 'Konfirmasi Kata Sandi',
                  icon: Icons.lock,
                  obscure: _obscureConfirm,
                  onToggle: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                const SizedBox(height: 22),

                // Checkbox persyaratan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agree,
                        activeColor: AppColors.primary,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (v) => setState(() => _agree = v ?? false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: GoogleFonts.inter(fontSize: 12),
                          children: [
                            const TextSpan(text: 'Saya telah membaca dan menyetujui '),
                            TextSpan(
                              text: 'persyaratan dan privasi pengguna',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.link,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Tombol buat akun
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'BUAT AKUN',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sudah punya akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Masuk',
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
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    VoidCallback? onToggle,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.fieldBorder),
    );
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          color: AppColors.iconGrey,
        ),
        errorStyle: GoogleFonts.inter(fontSize: 11),
        errorMaxLines: 2,
        filled: true,
        fillColor: AppColors.fieldBg,
        prefixIcon: Icon(icon, color: AppColors.iconGrey),
        suffixIcon: onToggle == null
            ? null
            : IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.iconGrey,
                ),
                onPressed: onToggle,
              ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}