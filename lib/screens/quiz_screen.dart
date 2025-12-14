import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/database_helper.dart'; // Import Database
import '../services/mock_auth_service.dart'; // Import Session User
import 'result_screen.dart'; // Import Halaman Hasil

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String categoryName;

  const QuizScreen({
    super.key, 
    required this.questions, 
    this.categoryName = "Kuis Seru",
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    // Acak urutan soal agar tidak bosan
    widget.questions.shuffle();
  }

  void _checkAnswer(int index) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      _selectedOptionIndex = index;
      if (index == widget.questions[_currentIndex].correctIndex) {
        _score += 10; // Tambah nilai 10 jika benar
      }
    });

    // Jeda sebentar sebelum lanjut ke soal berikutnya
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _isAnswered = false;
          _selectedOptionIndex = null;
        });
      } else {
        // PERBAIKAN DI SINI:
        // Jika soal habis, panggil fungsi finish (Simpan & Pindah)
        _finishQuiz(); 
      }
    });
  }

  // Fungsi Baru: Simpan ke DB & Pindah ke ResultScreen
  void _finishQuiz() async {
    // 1. Simpan Skor ke Database SQLite
    if (MockAuthService.currentUserEmail != null) {
      await DatabaseHelper.instance.saveScore(
        MockAuthService.currentUserEmail!, 
        "Latihan",           // Level (Bisa disesuaikan nanti)
        widget.categoryName, // Kategori (Matematika, dll)
        _score               // Skor Akhir
      );
    }

    // 2. Pindah ke Halaman Hasil (Replacement agar tidak bisa back ke soal)
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            total: widget.questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.categoryName),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Soal ${_currentIndex + 1}/${widget.questions.length}", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent)
              )
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentIndex + 1) / widget.questions.length,
              backgroundColor: Colors.grey[200],
              color: Colors.blueAccent,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 40),
            
            // Pertanyaan
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  currentQuestion.text,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Pilihan Jawaban
            Expanded(
              flex: 3,
              child: Column(
                children: List.generate(currentQuestion.options.length, (index) {
                  Color btnColor = Colors.white;
                  Color borderColor = Colors.blue.shade100;
                  
                  if (_isAnswered) {
                    if (index == currentQuestion.correctIndex) {
                      btnColor = Colors.green.shade100;
                      borderColor = Colors.green;
                    } else if (index == _selectedOptionIndex) {
                      btnColor = Colors.red.shade100;
                      borderColor = Colors.red;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () => _checkAnswer(index),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: btnColor,
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 4))
                          ]
                        ),
                        child: Text(
                          currentQuestion.options[index],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}