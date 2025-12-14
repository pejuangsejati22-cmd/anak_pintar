import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../data/question_bank.dart'; // Pastikan nama file sesuai (question_data.dart)
import '../widgets/level_card.dart';
import 'quiz_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  final Subject subject;

  const LevelSelectionScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    // 1. Menentukan Nama Judul berdasarkan Subject
    String subjectName;
    switch (subject) {
      case Subject.matematika:
        subjectName = "Matematika";
        break;
      case Subject.bahasa:
        subjectName = "Bahasa";
        break;
      case Subject.ipa:
        subjectName = "IPA";
        break;
      case Subject.ips:
        subjectName = "IPS";
        break;
    }

    // 2. Menentukan Warna Tema
    Color themeColor;
    switch (subject) {
      case Subject.matematika:
        themeColor = Colors.orange;
        break;
      case Subject.bahasa:
        themeColor = Colors.blue;
        break;
      case Subject.ipa:
        themeColor = Colors.green;
        break;
      case Subject.ips:
        themeColor = Colors.pink;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Background abu-abu muda lembut
      appBar: AppBar(
        title: Text("Kelas $subjectName", style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ubah ke stretch agar lebar penuh
          children: [
            const Text(
              "Pilih Tingkatan",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              "Sesuaikan dengan kemampuanmu ya!",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // --- KARTU LEVEL ---
            // Note: onTap sekarang memanggil _startQuiz, bukan _showSubjectSelector

            LevelCard(
              title: "PAUD",
              subtitle: "Pengenalan Dasar (3-5 Tahun)",
              color: Colors.pinkAccent,
              icon: Icons.toys_rounded,
              onTap: () => _startQuiz(context, Level.paud, subjectName),
            ),

            LevelCard(
              title: "TK",
              subtitle: "Persiapan Sekolah (5-7 Tahun)",
              color: Colors.purpleAccent,
              icon: Icons.backpack_rounded,
              onTap: () => _startQuiz(context, Level.tk, subjectName),
            ),

            LevelCard(
              title: "SD / MI",
              subtitle: "Sekolah Dasar (7-12 Tahun)",
              color: Colors.blueAccent,
              icon: Icons.school_rounded,
              onTap: () => _startQuiz(context, Level.sd, subjectName),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi Logika untuk Memulai Kuis
  void _startQuiz(BuildContext context, Level level, String subjectName) {
    // 1. Filter soal berdasarkan Subject (dari Constructor) DAN Level (dari Tombol)
    List<Question> filteredQuestions = questionBank
        .where((q) => q.subject == subject && q.level == level)
        .toList();

    // 2. Cek jika soal kosong
    if (filteredQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maaf, soal belum tersedia untuk kategori ini."),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          duration: Duration(seconds: 2),
        ),
      );
      return; 
    }

    // 3. Jika soal ada, lanjut ke QuizScreen
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          questions: filteredQuestions,
          categoryName: "$subjectName - ${level.name.toUpperCase()}", // Judul lebih detail
        ),
      ),
    );
  }
}