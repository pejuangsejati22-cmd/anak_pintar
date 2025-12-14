import 'package:flutter/material.dart';
import '../services/mock_auth_service.dart';
import '../data/question_bank.dart';
import '../models/question_model.dart';
import '../widgets/level_card.dart';
import 'quiz_screen.dart';
import 'login_screen.dart'; // Import Login Screen untuk navigasi balik

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // --- LOGIKA LOGOUT ---
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
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
          // Tombol Batal
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black87,
              elevation: 0,
            ),
            child: const Text("Tidak"),
          ),
          // Tombol Ya (Logout)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx); // Tutup Dialog
              
              // 1. Panggil Service Logout
              MockAuthService.logout();

              // 2. Kembali ke Login Screen & Hapus semua riwayat halaman sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // Syarat: Hapus semua rute
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Ya, Keluar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack untuk menumpuk background dekorasi dengan konten
      body: Stack(
        children: [
          _buildBackground(), // 1. Background Dekoratif
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- HEADER & APPBAR ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Kolom Teks Sapaan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo, ${MockAuthService.userName}! 🚀",
                            style: const TextStyle(
                              fontSize: 22, // Sedikit dikecilkan agar muat
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                              fontFamily: 'Arial Rounded MT Bold',
                            ),
                          ),
                          const Text(
                            "Ayo belajar sambil bermain",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      
                      // TOMBOL LOGOUT (ICON)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            )
                          ]
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                          tooltip: "Keluar Akun",
                          onPressed: () => _handleLogout(context),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // List Level (PAUD, TK, SD)
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    children: [
                      LevelCard(
                        title: "PAUD",
                        subtitle: "Pengenalan Dasar (3-5 Thn)",
                        color: Colors.pinkAccent,
                        icon: Icons.toys_rounded,
                        onTap: () => _showSubjectSelector(context, Level.paud, Colors.pinkAccent),
                      ),

                      LevelCard(
                        title: "TK",
                        subtitle: "Persiapan Sekolah (5-7 Thn)",
                        color: Colors.purpleAccent,
                        icon: Icons.backpack_rounded,
                        onTap: () => _showSubjectSelector(context, Level.tk, Colors.purpleAccent),
                      ),

                      LevelCard(
                        title: "SD / MI",
                        subtitle: "Sekolah Dasar (7-12 Thn)",
                        color: Colors.blueAccent,
                        icon: Icons.school_rounded,
                        onTap: () => _showSubjectSelector(context, Level.sd, Colors.blueAccent),
                      ),
                      
                      const SizedBox(height: 20),
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

  // Widget Background Bubble
  Widget _buildBackground() {
    return Container(
      color: const Color(0xFFF0F4F8),
      child: Stack(
        children: [
          Positioned(
            top: -50, right: -50,
            child: CircleAvatar(radius: 100, backgroundColor: Colors.blueAccent.withOpacity(0.1)),
          ),
          Positioned(
            bottom: -50, left: -50,
            child: CircleAvatar(radius: 100, backgroundColor: Colors.orangeAccent.withOpacity(0.1)),
          ),
          Positioned(
            top: 200, left: 30,
            child: CircleAvatar(radius: 20, backgroundColor: Colors.pinkAccent.withOpacity(0.1)),
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
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 50, height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 20),
            Text(
              "Pilih Pelajaran",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: availableSubjects.isEmpty
              ? const Center(child: Text("Belum ada soal untuk kategori ini."))
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

  // Tombol Subject (Matematika, dll)
  Widget _buildSubjectButton(BuildContext context, Subject subject, Level level, Color color) {
    String label = subject.name.toUpperCase();
    IconData icon;

    switch (subject) {
      case Subject.matematika: icon = Icons.calculate; break;
      case Subject.bahasa: icon = Icons.menu_book; break;
      case Subject.ipa: icon = Icons.science; break;
      case Subject.ips: icon = Icons.public; break;
      default: icon = Icons.star;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: () {
        Navigator.pop(context); // Tutup Modal

        // Filter Soal
        final filteredQuestions = questionBank.where((q) {
          return q.level == level && q.subject == subject;
        }).toList();

        if (filteredQuestions.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Soal belum tersedia untuk saat ini.")),
          );
        } else {
          // Navigasi ke Kuis
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(
                questions: filteredQuestions,
                categoryName: label,
              ),
            ),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}