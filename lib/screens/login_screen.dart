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

  // Warna Tema Game
  final Color _primaryColor = const Color(0xFF6C5CE7); // Purple Game
  final Color _accentColor = const Color(0xFF00E676); // Green Success
  final Color _borderColor = Colors.black;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    var user = await DatabaseHelper.instance.loginUser(
      _emailController.text, 
      _passwordController.text
    );

    if (user != null) {
      MockAuthService.currentUserEmail = user['email'] as String;
      MockAuthService.currentUserName = user['name'] as String;

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      if (mounted) {
        // Custom SnackBar Game Style
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.error_outline_rounded, color: Colors.white),
                SizedBox(width: 10),
                Text("Email/Password Salah!", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            backgroundColor: const Color(0xFFFF5252),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1), // Background Cream Hangat
      body: Stack(
        children: [
          // 1. Background Pattern
          const Positioned.fill(child: _GameBackgroundPattern()),
          
          // 2. Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- LOGO GAME ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: _borderColor, width: 3),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 0)
                      ],
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, size: 50, color: Colors.orangeAccent),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "PLAYER LOGIN",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: _primaryColor,
                      letterSpacing: 2,
                      shadows: const [Shadow(color: Colors.black12, offset: Offset(2, 2))],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- PANEL LOGIN (GAME CARD) ---
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: _borderColor, width: 3), // Border Tebal
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, // Shadow Hard
                          offset: Offset(0, 10),
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Siap Bermain?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 25),
                        
                        // Input Email
                        _GameTextField(
                          controller: _emailController,
                          label: "EMAIL",
                          icon: Icons.alternate_email_rounded,
                          isObscure: false,
                        ),
                        const SizedBox(height: 20),
                        
                        // Input Password
                        _GameTextField(
                          controller: _passwordController,
                          label: "PASSWORD",
                          icon: Icons.lock_outline_rounded,
                          isObscure: true,
                        ),
                        const SizedBox(height: 30),
                        
                        // Tombol Login 3D
                        _Game3DActionButton(
                          label: "START GAME",
                          color: _accentColor, // Hijau
                          shadowColor: const Color(0xFF00B248),
                          isLoading: _isLoading,
                          onTap: _handleLogin,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // Footer Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Player Baru? ", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                        },
                        child: Text(
                          "DAFTAR SINI",
                          style: TextStyle(
                            color: _primaryColor, 
                            fontWeight: FontWeight.w900,
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
}

// --- WIDGETS KHUSUS GAME STYLE ---

// 1. Input Field ala "Slot Game"
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
            border: Border.all(color: Colors.black, width: 2), // Border Hitam
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

// 2. Tombol Aksi 3D (Start Game)
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

// 3. Background Pattern (Sama seperti Home)
class _GameBackgroundPattern extends StatelessWidget {
  const _GameBackgroundPattern();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFF5E1)),
      child: Stack(
        children: [
          // Dot Grid
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: _DotGridPainter()),
            ),
          ),
          // Dekorasi
          Positioned(
            top: -50, left: -50,
            child: CircleAvatar(radius: 100, backgroundColor: Colors.purple.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 100, right: -20,
            child: Icon(Icons.gamepad, size: 100, color: Colors.blueAccent.withOpacity(0.05)),
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