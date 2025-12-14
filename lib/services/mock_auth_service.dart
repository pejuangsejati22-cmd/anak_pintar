// lib/services/mock_auth_service.dart

class MockAuthService {
  // Variabel STATIC untuk menyimpan sesi login di memori sementara
  // Kita buat public (tanpa tanda '_') agar bisa diisi dari Login Screen
  static String? currentUserEmail;
  static String? currentUserName;

  // Getter nama user (biar aman kalau null)
  static String get userName => currentUserName ?? "Petualang";

  // Cek status login
  static bool get isLoggedIn => currentUserEmail != null;

  // Fungsi Logout (Hapus sesi)
  static void logout() {
    currentUserEmail = null;
    currentUserName = null;
  }
}