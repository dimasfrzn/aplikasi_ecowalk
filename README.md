# EcoWalk

Aplikasi mobile **EcoWalk** dibuat dengan Flutter sebagai **Tugas 1 Pemrograman Mobile**. Tampilan (UI) mengikuti desain Figma EcoWalk: splash, login, registrasi, verifikasi OTP, lupa kata sandi, dan profil.

- **Nama:** Dimas Wahyu Firziansyah
- **NIM:** 41824010088
- **Mata kuliah:** Pemrograman Mobile

## Fitur

1. **Splash screen**: tampil 3 detik lalu otomatis pindah ke halaman Login.
2. **Login**: masuk dengan nama pengguna dan kata sandi (akun demo), tombol tampil/sembunyikan kata sandi, tautan Lupa Kata Sandi dan Daftar.
3. **Buat akun**: form nama pengguna, email, nomor HP, kata sandi, dan konfirmasi kata sandi, lengkap dengan validasi dan persetujuan syarat.
4. **Verifikasi OTP**: 4 digit kode, bisa lewat nomor HP atau email, dan bisa berpindah metode.
5. **Lupa kata sandi**: verifikasi lewat email atau nomor HP, lalu OTP, lalu kata sandi baru.
6. **Profil**: informasi akun, daftar menu, bottom navigation, dan logout dengan konfirmasi.

## Alur Aplikasi

**Daftar akun**

Buat Akun, lalu Verifikasi OTP (nomor HP atau email sesuai isian form), lalu Login.
Jika metode diganti, pindah ke layar verifikasi metode lain dengan data dari form yang sama.

**Lupa kata sandi**

Lupa Kata Sandi (email atau nomor HP), lalu Verifikasi OTP, lalu Kata Sandi Baru, lalu Login.
Jika metode diganti di layar OTP, pengguna harus memasukkan dan memverifikasi ulang email atau nomor HP tersebut.

## Akun dan Kode Demo

Aplikasi ini **belum menggunakan database atau server**, jadi data bersifat simulasi.

| Keperluan | Nilai |
|---|---|
| Nama pengguna | `ecowalk` |
| Kata sandi | `ecowalk123` |
| Kode OTP (semua layar verifikasi) | `1234` |

Akun yang didaftarkan dan kata sandi baru **tidak disimpan**, sehingga login tetap memakai akun demo di atas.

## Validasi Form

- **Nama pengguna:** wajib, 3 sampai 20 karakter, hanya huruf, angka, titik, dan underscore.
- **Email:** wajib, format email valid.
- **Nomor HP:** wajib, format Indonesia (`08...`, `628...`, atau `+628...`), 10 sampai 13 digit.
- **Kata sandi:** wajib, minimal 8 karakter, mengandung huruf dan angka.
- **Konfirmasi kata sandi baru:** wajib dan harus sama dengan kata sandi baru.

## Struktur Folder

```
lib/
├── main.dart
├── assets/images/            # logo, ikon Google, foto profil
├── models/
│   └── verification_flow.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── verification_phone_screen.dart
│   ├── verification_email_screen.dart
│   ├── forgot_password_email_screen.dart
│   ├── forgot_password_phone_screen.dart
│   ├── new_password_screen.dart
│   └── profile_screen.dart
├── theme/
│   └── app_colors.dart
└── widgets/
    └── auth_header.dart
```

## Teknologi

- Flutter (Dart)
- [google_fonts](https://pub.dev/packages/google_fonts) untuk font

## Cara Menjalankan

1. Pastikan Flutter sudah terpasang dan emulator Android (Android Studio) menyala.
2. Clone repo ini:
```bash
   git clone https://github.com/dimasfrzn/aplikasi_ecowalk.git
   cd aplikasi_ecowalk
```
3. Ambil dependensi:
```bash
   flutter pub get
```
4. Jalankan aplikasi:
```bash
   flutter run
```
