class MockAuthService {
  // 1. Simpan user di memori (Map: email -> password)
  static final Map<String, String> _users = {
    'admin@belajar.com': '123456', // User default untuk testing
  };

  // 2. Simpan nama user (Map: email -> Nama Lengkap)
  static final Map<String, String> _userNames = {
    'admin@belajar.com': 'Admin Genius',
  };

  // Variabel private untuk menyimpan sesi login saat ini
  static String? _currentUserEmail;
  static String? _currentUserName;

  // --- GETTERS (Untuk mengambil data dengan aman) ---

  // Mengambil nama user yang sedang login. 
  // Jika null (belum login), kembalikan "Petualang"
  static String get userName => _currentUserName ?? "Petualang";

  // Cek apakah ada user yang sedang login
  static bool get isLoggedIn => _currentUserEmail != null;

  // --- FUNGSI UTAMA ---

  // Fungsi Login
  static bool login(String email, String password) {
    // Bersihkan spasi depan/belakang agar tidak error typo
    final cleanEmail = email.trim(); 
    
    if (_users.containsKey(cleanEmail) && _users[cleanEmail] == password) {
      _currentUserEmail = cleanEmail;
      _currentUserName = _userNames[cleanEmail];
      return true; // Login Sukses
    }
    return false; // Login Gagal
  }

  // Fungsi Sign Up
  static bool signUp(String name, String email, String password) {
    final cleanEmail = email.trim();
    final cleanName = name.trim();

    if (_users.containsKey(cleanEmail)) {
      return false; // Gagal: Email sudah terdaftar
    }

    // Simpan data baru ke memori
    _users[cleanEmail] = password;
    _userNames[cleanEmail] = cleanName;
    return true; // Daftar Sukses
  }

  // Fungsi Logout
  static void logout() {
    _currentUserEmail = null;
    _currentUserName = null;
  }
}