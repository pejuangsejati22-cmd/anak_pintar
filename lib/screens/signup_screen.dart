import 'package:flutter/material.dart';
import '../services/database_helper.dart'; 

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignup() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("Semua kolom harus diisi ya!", Colors.orange);
      return;
    }

    setState(() => _isLoading = true);
    
    // PANGGIL DATABASE HELPER (Simpan ke SQLite)
    bool success = await DatabaseHelper.instance.registerUser(name, email, password);

    if (success) {
      // Cek apakah layar masih aktif sebelum menampilkan SnackBar
      if (!mounted) return;
      _showSnackBar("Hore! Berhasil daftar. Silakan login.", Colors.green);
      
      // Tunggu 1 detik
      await Future.delayed(const Duration(seconds: 1)); 
      
      // PERBAIKAN PENTING DI SINI:
      // Cek 'mounted' LAGI setelah bangun dari tidur (await).
      // Kita harus memastikan layar masih ada sebelum menyuruhnya keluar (pop).
      if (mounted) {
        Navigator.pop(context); // Kembali ke Login
      }

    } else {
      if (mounted) {
        _showSnackBar("Yah, Email sudah terpakai!", Colors.redAccent);
      }
    }

    // Stop loading hanya jika layar masih ada
    if (mounted) setState(() => _isLoading = false);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          _buildBackground(), // Background Dekoratif
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ikon Daftar
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.person_add_alt_1_rounded, size: 50, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 20),

                  // Kartu Form
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Buat Akun Baru",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                              fontFamily: 'Arial Rounded MT Bold',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Isi data dirimu di bawah ini",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 30),
                          
                          // Input Nama
                          _buildTextField(
                            controller: _nameController,
                            label: "Nama Lengkap",
                            icon: Icons.person_rounded,
                            isObscure: false,
                          ),
                          const SizedBox(height: 16),

                          // Input Email
                          _buildTextField(
                            controller: _emailController,
                            label: "Email",
                            icon: Icons.email_rounded,
                            isObscure: false,
                          ),
                          const SizedBox(height: 16),
                          
                          // Input Password
                          _buildTextField(
                            controller: _passwordController,
                            label: "Password",
                            icon: Icons.lock_rounded,
                            isObscure: true,
                          ),
                          const SizedBox(height: 30),
                          
                          // Tombol Daftar
                          SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSignup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6C63FF),
                                foregroundColor: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: _isLoading 
                                ? const SizedBox(
                                    width: 24, height: 24,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
                                  )
                                : const Text(
                                    "DAFTAR SEKARANG", 
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Custom Input Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
        filled: true,
        fillColor: const Color(0xFFF5F6FA), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  // Widget Background Bubble
  Widget _buildBackground() {
    return Container(
      color: const Color(0xFFF0F4F8),
      child: Stack(
        children: [
          Positioned(
            top: -60, left: -60,
            child: CircleAvatar(radius: 120, backgroundColor: Colors.blueAccent.withOpacity(0.1)),
          ),
          Positioned(
            bottom: -40, right: -40,
            child: CircleAvatar(radius: 100, backgroundColor: Colors.orangeAccent.withOpacity(0.1)),
          ),
          Positioned(
            top: 100, right: 30,
            child: CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent.withOpacity(0.1)),
          ),
        ],
      ),
    );
  }
}