import 'package:flutter/material.dart';
import '../services/mock_auth_service.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import '../services/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    // Cek ke Database Asli
    var user = await DatabaseHelper.instance.loginUser(
      _emailController.text, 
      _passwordController.text
    );

    if (user != null) {
      // Jika Login Sukses:
      // Simpan data user ke 'Session Memory' (MockAuthService)
      // Menggunakan 'as String' untuk memastikan tipe data aman
      MockAuthService.currentUserEmail = user['email'] as String;
      MockAuthService.currentUserName = user['name'] as String;

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      // Jika Login Gagal
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Email atau password salah!"),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan Stack agar background bisa di belakang form
      body: Stack(
        children: [
          _buildBackground(), // Background dekoratif
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ikon Besar di atas
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // PERBAIKAN: Menggunakan withValues
                          color: Colors.deepPurple.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, size: 60, color: Colors.orangeAccent),
                  ),
                  const SizedBox(height: 30),

                  // Kartu Form Login
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    // PERBAIKAN: Menggunakan withValues
                    shadowColor: Colors.deepPurple.withValues(alpha: 0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Selamat Datang!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26, 
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                              fontFamily: 'Arial Rounded MT Bold',
                              // Tambahan: Fallback font agar aman
                              fontFamilyFallback: ['Roboto', 'sans-serif'],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Masuk untuk mulai petualangan",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 30),
                          
                          // Input Email
                          _buildTextField(
                            controller: _emailController,
                            label: "Email",
                            icon: Icons.email_rounded,
                            isObscure: false,
                          ),
                          const SizedBox(height: 20),
                          
                          // Input Password
                          _buildTextField(
                            controller: _passwordController,
                            label: "Password",
                            icon: Icons.lock_rounded,
                            isObscure: true,
                          ),
                          const SizedBox(height: 30),
                          
                          // Tombol Login
                          SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
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
                                    "MASUK SEKARANG", 
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // Tombol Daftar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Belum punya akun? ", style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                        },
                        child: const Text(
                          "Daftar Yuk!",
                          style: TextStyle(
                            color: Colors.deepPurple, 
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget custom untuk Input Field agar lebih soft
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

  // Widget Background Bubble (Updated to withValues)
  Widget _buildBackground() {
    return Container(
      color: const Color(0xFFF0F4F8),
      child: Stack(
        children: [
          Positioned(
            top: -60, left: -60,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 120, backgroundColor: Colors.blueAccent.withValues(alpha: 0.1)),
          ),
          Positioned(
            bottom: -40, right: -40,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 100, backgroundColor: Colors.orangeAccent.withValues(alpha: 0.1)),
          ),
          Positioned(
            top: 100, right: 30,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent.withValues(alpha: 0.1)),
          ),
        ],
      ),
    );
  }
}