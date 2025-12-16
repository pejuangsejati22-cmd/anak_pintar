import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../data/question_bank.dart'; 
import 'quiz_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  final Subject subject;

  const LevelSelectionScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    // 1. Menentukan Nama & Warna Tema berdasarkan Subject
    String subjectName;
    Color themeColor;
    IconData subjectIcon;

    switch (subject) {
      case Subject.matematika:
        subjectName = "Matematika";
        themeColor = const Color(0xFF4ECDC4); // Tosca Game
        subjectIcon = Icons.calculate_rounded;
        break;
      case Subject.bahasa:
        subjectName = "Bahasa";
        themeColor = const Color(0xFFFF6B6B); // Coral Red
        subjectIcon = Icons.abc_rounded;
        break;
      case Subject.ipa:
        subjectName = "IPA";
        themeColor = const Color(0xFF6C5CE7); // Purple Game
        subjectIcon = Icons.biotech_rounded;
        break;
      case Subject.ips:
        subjectName = "IPS";
        themeColor = const Color(0xFFFFA502); // Orange
        subjectIcon = Icons.public_rounded;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1), // Background Cream Hangat
      body: Stack(
        children: [
          // Background Pattern
          const Positioned.fill(child: _GameBackgroundPattern()),
          
          SafeArea(
            child: Column(
              children: [
                // --- 1. CUSTOM HEADER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      // Tombol Back 3D
                      GestureDetector(
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
                      
                      const SizedBox(width: 15),

                      // Badge Judul Pelajaran
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 3),
                            boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 0)],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(subjectIcon, color: Colors.white, size: 24),
                              const SizedBox(width: 10),
                              Text(
                                "KELAS ${subjectName.toUpperCase()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  shadows: [Shadow(color: Colors.black26, offset: Offset(1, 1))]
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- 2. JUDUL HALAMAN ---
                const Text(
                  "PILIH TINGKATAN",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  "Sesuaikan dengan kemampuanmu!",
                  style: TextStyle(
                    color: Colors.grey[700], 
                    fontSize: 14, 
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 30),

                // --- 3. DAFTAR LEVEL (Scrollable) ---
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _GameLevelCard(
                        title: "PAUD",
                        subtitle: "Level 1: Pemula (3-5 Thn)",
                        baseColor: const Color(0xFFFF6B6B), // Red
                        shadowColor: const Color(0xFFC92A2A),
                        icon: Icons.toys_rounded,
                        onTap: () => _startQuiz(context, Level.paud, subjectName),
                      ),
                      const SizedBox(height: 20),
                      _GameLevelCard(
                        title: "TK",
                        subtitle: "Level 2: Petualang (5-7 Thn)",
                        baseColor: const Color(0xFF4ECDC4), // Teal
                        shadowColor: const Color(0xFF2B9E96),
                        icon: Icons.backpack_rounded,
                        onTap: () => _startQuiz(context, Level.tk, subjectName),
                      ),
                      const SizedBox(height: 20),
                      _GameLevelCard(
                        title: "SD / MI",
                        subtitle: "Level 3: Juara (7-12 Thn)",
                        baseColor: const Color(0xFF45B7D1), // Blue
                        shadowColor: const Color(0xFF2A8BA0),
                        icon: Icons.school_rounded,
                        onTap: () => _startQuiz(context, Level.sd, subjectName),
                      ),
                      const SizedBox(height: 40), // Ruang bawah
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi Logika untuk Memulai Kuis
  void _startQuiz(BuildContext context, Level level, String subjectName) {
    List<Question> filteredQuestions = questionBank
        .where((q) => q.subject == subject && q.level == level)
        .toList();

    if (filteredQuestions.isEmpty) {
      // SnackBar Custom Game Style
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.lock_clock, color: Colors.white),
              SizedBox(width: 10),
              Text("Level ini belum tersedia!", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
          elevation: 0,
        ),
      );
      return; 
    }

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          questions: filteredQuestions,
          categoryName: "$subjectName - ${level.name.toUpperCase()}", 
        ),
      ),
    );
  }
}

// --- WIDGETS REUSABLE (Agar tidak perlu import dari file lain) ---

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
                color: Colors.white.withOpacity(0.2), // Pakai withOpacity agar aman
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded( // Gunakan Expanded agar teks tidak overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24, // Sedikit diperkecil agar muat
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2))]
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Cegah overflow
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 10),
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
            top: -50, right: -50,
            child: Icon(Icons.star, size: 150, color: Colors.yellow.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 50, left: -20,
            child: Icon(Icons.extension, size: 120, color: Colors.blue.withOpacity(0.05)),
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