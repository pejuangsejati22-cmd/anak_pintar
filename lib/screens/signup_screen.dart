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

  // Warna Tema
  final Color _primaryColor = const Color(0xFF0984E3); // Blue Game
  final Color _accentColor = const Color(0xFF00E676); // Green Success

  Future<void> _handleSignup() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showGameSnackBar("Data belum lengkap, nih!", Colors.orange, Icons.warning_rounded);
      return;
    }

    setState(() => _isLoading = true);
    
    // Simpan ke SQLite
    bool success = await DatabaseHelper.instance.registerUser(name, email, password);

    if (success) {
      if (!mounted) return;
      _showGameSnackBar("Hore! Akun berhasil dibuat.", _accentColor, Icons.check_circle_rounded);
      
      await Future.delayed(const Duration(seconds: 1)); 
      
      if (mounted) {
        Navigator.pop(context); // Kembali ke Login
      }

    } else {
      if (mounted) {
        _showGameSnackBar("Yah, Email sudah terpakai!", const Color(0xFFFF5252), Icons.error_rounded);
      }
    }

    if (mounted) setState(() => _isLoading = false);
  }

  // Custom SnackBar Game Style
  void _showGameSnackBar(String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1), // Background Cream
      body: Stack(
        children: [
          // 1. Background Pattern
          const Positioned.fill(child: _GameBackgroundPattern()),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- HEADER (BACK BUTTON) ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 0)],
                        ),
                        child: const Icon(Icons.arrow_back_rounded, color: Colors.black, size: 28),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- JUDUL & ICON ---
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 3),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 0)
                        ],
                      ),
                      child: const Icon(Icons.person_add_alt_1_rounded, size: 50, color: Colors.blueAccent),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "NEW PLAYER",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28, 
                      fontWeight: FontWeight.w900,
                      color: _primaryColor,
                      letterSpacing: 2,
                      shadows: const [Shadow(color: Colors.black12, offset: Offset(2, 2))]
                    ),
                  ),
                  
                  const SizedBox(height: 30),

                  // --- FORM CARD ---
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 10),
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Buat Profil Kamu",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
                        ),
                        const SizedBox(height: 25),

                        // Input Nama
                        _GameTextField(
                          controller: _nameController,
                          label: "NAMA LENGKAP",
                          icon: Icons.badge_rounded,
                          isObscure: false,
                        ),
                        const SizedBox(height: 15),

                        // Input Email
                        _GameTextField(
                          controller: _emailController,
                          label: "EMAIL",
                          icon: Icons.email_rounded,
                          isObscure: false,
                        ),
                        const SizedBox(height: 15),
                        
                        // Input Password
                        _GameTextField(
                          controller: _passwordController,
                          label: "PASSWORD",
                          icon: Icons.lock_rounded,
                          isObscure: true,
                        ),
                        const SizedBox(height: 30),
                        
                        // Tombol Daftar 3D
                        _Game3DActionButton(
                          label: "SIMPAN DATA",
                          color: _primaryColor,
                          shadowColor: const Color(0xFF00509E), // Darker Blue
                          isLoading: _isLoading,
                          onTap: _handleSignup,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGETS KHUSUS GAME STYLE (Reusable dari Login) ---

class _GameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isObscure;

  const _GameTextField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.grey)
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: TextField(
            controller: controller,
            obscureText: isObscure,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.black87),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class _Game3DActionButton extends StatefulWidget {
  final String label;
  final Color color;
  final Color shadowColor;
  final VoidCallback onTap;
  final bool isLoading;

  const _Game3DActionButton({
    required this.label,
    required this.color,
    required this.shadowColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<_Game3DActionButton> createState() => _Game3DActionButtonState();
}

class _Game3DActionButtonState extends State<_Game3DActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 55,
        transform: Matrix4.translationValues(0, _isPressed ? 6 : 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(0, 6),
                    blurRadius: 0,
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: widget.isLoading
            ? const SizedBox(
                width: 24, height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
              )
            : Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
      ),
    );
  }
}

class _GameBackgroundPattern extends StatelessWidget {
  const _GameBackgroundPattern();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFF5E1)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: _DotGridPainter()),
            ),
          ),
          Positioned(
            top: -30, right: -30,
            child: Icon(Icons.flash_on_rounded, size: 120, color: Colors.orange.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 50, left: -20,
            child: Icon(Icons.extension, size: 100, color: Colors.purple.withOpacity(0.05)),
          ),
        ],
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey..strokeCap = StrokeCap.round..strokeWidth = 2;
    const step = 40.0;
    for (double y = 0; y < size.height; y += step) {
      for (double x = 0; x < size.width; x += step) {
        if ((x / step).floor() % 2 == (y / step).floor() % 2) {
          canvas.drawCircle(Offset(x, y), 1.5, paint);
        }
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}