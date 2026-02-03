import 'package:flutter/material.dart';
import '../services/mock_auth_service.dart';
import '../data/question_bank.dart'; 
import '../models/question_model.dart';
// import '../widgets/level_card.dart'; // Kita ganti dengan Custom Game Card di bawah
import 'quiz_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // --- DATA LEVEL (Konfigurasi Menu) ---
  final List<Map<String, dynamic>> _levels = const [
    {
      'title': "PAUD",
      'subtitle': "Level 1: Pemula",
      'level': Level.paud,
      'color': Color(0xFFFF6B6B), // Coral Red
      'shadow': Color(0xFFC92A2A),
      'icon': Icons.toys_rounded,
    },
    {
      'title': "TK",
      'subtitle': "Level 2: Petualang",
      'level': Level.tk,
      'color': Color(0xFF4ECDC4), // Teal
      'shadow': Color(0xFF2B9E96),
      'icon': Icons.backpack_rounded,
    },
    {
      'title': "SD / MI",
      'subtitle': "Level 3: Juara",
      'level': Level.sd,
      'color': Color(0xFF45B7D1), // Sky Blue
      'shadow': Color(0xFF2A8BA0),
      'icon': Icons.school_rounded,
    },
  ];

  // --- LOGIKA LOGOUT ---
  void _handleLogout(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Logout",
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.elasticOut),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Colors.black, width: 3),
            ),
            title: const Column(
              children: [
                Icon(Icons.exit_to_app_rounded, size: 60, color: Colors.redAccent),
                SizedBox(height: 10),
                Text("GAME OVER?", 
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black87)
                ),
              ],
            ),
            content: const Text(
              "Yakin ingin keluar dari permainan?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              _Game3DButton(
                color: Colors.grey,
                shadowColor: Colors.grey[700]!,
                label: "Batal",
                onTap: () => Navigator.pop(ctx),
                width: 100,
                height: 45,
              ),
              const SizedBox(width: 15),
              _Game3DButton(
                color: Colors.redAccent,
                shadowColor: const Color(0xFFB71C1C),
                label: "Keluar",
                onTap: () {
                  Navigator.pop(ctx);
                  MockAuthService.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                width: 100,
                height: 45,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1), // Warm background
      body: Stack(
        children: [
          const _GameBackgroundPattern(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGameHeader(context),
                
                const SizedBox(height: 10),
                
                // --- LIST LEVEL ---
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    itemCount: _levels.length,
                    separatorBuilder: (ctx, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final data = _levels[index];
                      return _GameLevelCard(
                        title: data['title'],
                        subtitle: data['subtitle'],
                        baseColor: data['color'],
                        shadowColor: data['shadow'],
                        icon: data['icon'],
                        onTap: () => _showSubjectSelector(
                          context, 
                          data['level'], 
                          data['color'],
                          data['shadow']
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HUD / Header Widget
  Widget _buildGameHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3), // Cartoon border
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 6),
              blurRadius: 0,
            )
          ]
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.amberAccent,
              ),
              padding: const EdgeInsets.all(2),
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.face_rounded, size: 35, color: Colors.black),
              ),
            ),
            const SizedBox(width: 12),
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MockAuthService.userName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent[400],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: const Text(
                      "ONLINE",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // Logout Button
            IconButton(
              icon: const Icon(Icons.power_settings_new_rounded, color: Colors.red, size: 32),
              onPressed: () => _handleLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  // Logic Memilih Pelajaran
  void _showSubjectSelector(BuildContext context, Level level, Color color, Color shadowColor) {
    final availableSubjects = questionBank
        .where((q) => q.level == level)
        .map((q) => q.subject)
        .toSet()
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          border: Border(
            top: BorderSide(color: Colors.black, width: 4),
            left: BorderSide(color: Colors.black, width: 4),
            right: BorderSide(color: Colors.black, width: 4),
          )
        ),
        padding: const EdgeInsets.fromLTRB(24, 15, 24, 24),
        child: Column(
          children: [
            Container(
              width: 60, height: 6,
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: Colors.grey[300], 
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            
            Text(
              "PILIH MISI",
              style: TextStyle(
                fontSize: 26, 
                fontWeight: FontWeight.w900, 
                color: color,
                shadows: const [
                  Shadow(offset: Offset(1,1), color: Colors.black12)
                ]
              ),
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: availableSubjects.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_clock, size: 60, color: Colors.grey[300]),
                    const SizedBox(height: 10),
                    const Text("Misi belum tersedia.", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: availableSubjects.length,
                  itemBuilder: (context, index) {
                    return _buildSubjectButton(context, availableSubjects[index], level, color, shadowColor);
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol Subject (Game Style)
  Widget _buildSubjectButton(BuildContext context, Subject subject, Level level, Color color, Color shadowColor) {
    String label = subject.name.toUpperCase();
    
    final iconMap = {
      Subject.matematika: Icons.calculate_rounded,
      Subject.bahasa: Icons.abc_rounded,
      Subject.ipa: Icons.biotech_rounded,
      Subject.ips: Icons.public_rounded,
    };
    
    IconData icon = iconMap[subject] ?? Icons.star_rounded;
    
    return _Game3DButton(
      color: Colors.white,
      shadowColor: Colors.grey[300]!,
      borderColor: color,
      onTap: () {
        Navigator.pop(context);
        _navigateToQuiz(context, level, subject, label);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900, 
              fontSize: 16, 
              color: color
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToQuiz(BuildContext context, Level level, Subject subject, String title) {
    final filteredQuestions = questionBank.where((q) {
      return q.level == level && q.subject == subject;
    }).toList();

    if (filteredQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Level ini sedang dibangun!", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            questions: filteredQuestions,
            categoryName: title,
          ),
        ),
      );
    }
  }
}

// --- WIDGET KHUSUS TEMA GAME (PREMIUM) ---

class _GameLevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color baseColor;
  final Color shadowColor;
  final IconData icon;
  final VoidCallback onTap;

  const _GameLevelCard({
    required this.title,
    required this.subtitle,
    required this.baseColor,
    required this.shadowColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 8), // Efek 3D Tebal
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2))]
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_arrow_rounded, color: baseColor, size: 28),
            )
          ],
        ),
      ),
    );
  }
}

// Tombol 3D Reusable
class _Game3DButton extends StatefulWidget {
  final Color color;
  final Color shadowColor;
  final Color? borderColor;
  final String? label;
  final Widget? child;
  final VoidCallback onTap;
  final double? width;
  final double? height;

  const _Game3DButton({
    required this.color,
    required this.shadowColor,
    this.borderColor,
    this.label,
    this.child,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  State<_Game3DButton> createState() => _Game3DButtonState();
}

class _Game3DButtonState extends State<_Game3DButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.borderColor ?? Colors.black, width: 2),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: widget.child ?? Text(
          widget.label ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
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
      decoration: const BoxDecoration(
        color: Color(0xFFFFF5E1),
      ),
      child: Stack(
        children: [
          // Pola Grid Dot
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: DotGridPainter(),
              ),
            ),
          ),
          // Elemen Dekoratif Floating
          Positioned(
            top: 50, right: -20,
            child: Icon(Icons.cloud, size: 100, color: Colors.blueAccent.withOpacity(0.1)),
          ),
          Positioned(
            top: 150, left: -20,
            child: Icon(Icons.star, size: 80, color: Colors.amber.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 50, right: 30,
            child: Icon(Icons.videogame_asset, size: 120, color: Colors.purple.withOpacity(0.05)),
          ),
        ],
      ),
    );
  }
}

// Painter sederhana untuk background dot
class DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

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