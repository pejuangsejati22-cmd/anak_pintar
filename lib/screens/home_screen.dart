import 'package:flutter/material.dart';
import '../services/mock_auth_service.dart';
import '../data/question_bank.dart'; 
import '../models/question_model.dart';
import '../widgets/level_card.dart';
import 'quiz_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // --- DATA LEVEL (Konfigurasi Menu) ---
  final List<Map<String, dynamic>> _levels = const [
    {
      'title': "PAUD",
      'subtitle': "Pengenalan Dasar (3-5 Thn)",
      'level': Level.paud,
      'color': Colors.pinkAccent,
      'icon': Icons.toys_rounded,
    },
    {
      'title': "TK",
      'subtitle': "Persiapan Sekolah (5-7 Thn)",
      'level': Level.tk,
      'color': Colors.purpleAccent,
      'icon': Icons.backpack_rounded,
    },
    {
      'title': "SD / MI",
      'subtitle': "Sekolah Dasar (7-12 Thn)",
      'level': Level.sd,
      'color': Colors.blueAccent,
      'icon': Icons.school_rounded,
    },
  ];

  // --- LOGIKA LOGOUT ---
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.logout_rounded, size: 50, color: Colors.redAccent),
            SizedBox(height: 10),
            Text("Mau Keluar?", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "Apakah kamu yakin ingin berhenti bermain dan keluar akun?",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Tidak"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              MockAuthService.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Ya, Keluar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BuildBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 10),
                
                // --- LIST LEVEL ---
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: _levels.length,
                    separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final data = _levels[index];
                      return LevelCard(
                        title: data['title'],
                        subtitle: data['subtitle'],
                        color: data['color'],
                        icon: data['icon'],
                        onTap: () => _showSubjectSelector(
                          context, 
                          data['level'], 
                          data['color']
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

  // Header Widget
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, ${MockAuthService.userName}! 🚀",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    fontFamily: 'Arial Rounded MT Bold', 
                    fontFamilyFallback: ['Roboto', 'sans-serif'], 
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  "Ayo belajar sambil bermain",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // PERBAIKAN: Menggunakan withValues
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              tooltip: "Keluar Akun",
              onPressed: () => _handleLogout(context),
            ),
          ),
        ],
      ),
    );
  }

  // Logic Memilih Pelajaran
  void _showSubjectSelector(BuildContext context, Level level, Color color) {
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
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
        child: Column(
          children: [
            Container(
              width: 50, height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300], 
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            
            Text(
              "Pilih Pelajaran",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: availableSubjects.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_off_rounded, size: 50, color: Colors.grey[300]),
                    const SizedBox(height: 10),
                    const Text("Belum ada soal tersedia.", style: TextStyle(color: Colors.grey)),
                  ],
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: availableSubjects.length,
                  itemBuilder: (context, index) {
                    return _buildSubjectButton(context, availableSubjects[index], level, color);
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol Subject
  Widget _buildSubjectButton(BuildContext context, Subject subject, Level level, Color color) {
    String label = subject.name.toUpperCase();
    
    final iconMap = {
      Subject.matematika: Icons.calculate_rounded,
      Subject.bahasa: Icons.menu_book_rounded,
      Subject.ipa: Icons.science_rounded,
      Subject.ips: Icons.public_rounded,
    };
    
    IconData icon = iconMap[subject] ?? Icons.star_rounded;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          _navigateToQuiz(context, level, subject, label);
        },
        borderRadius: BorderRadius.circular(15),
        // PERBAIKAN: Menggunakan withValues
        splashColor: color.withValues(alpha: 0.3),
        child: Container(
          decoration: BoxDecoration(
            // PERBAIKAN: Menggunakan withValues
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 14, 
                      color: color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context, Level level, Subject subject, String title) {
    final filteredQuestions = questionBank.where((q) {
      return q.level == level && q.subject == subject;
    }).toList();

    if (filteredQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Soal sedang dalam perbaikan/update.")),
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

// --- WIDGET BACKGROUND ---
class _BuildBackground extends StatelessWidget {
  const _BuildBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F4F8),
      child: Stack(
        children: [
          Positioned(
            top: -50, right: -50,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 100, backgroundColor: Colors.blueAccent.withValues(alpha: 0.1)),
          ),
          Positioned(
            bottom: -50, left: -50,
            // PERBAIKAN: Typo (0.) diperbaiki jadi 0.1 dan menggunakan withValues
            child: CircleAvatar(radius: 100, backgroundColor: Colors.orangeAccent.withValues(alpha: 0.1)),
          ),
          Positioned(
            top: 200, left: 30,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 20, backgroundColor: Colors.pinkAccent.withValues(alpha: 0.1)),
          ),
        ],
      ),
    );
  }
}