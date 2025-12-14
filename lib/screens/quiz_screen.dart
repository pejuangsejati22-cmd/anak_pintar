import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizScreen extends StatefulWidget {
  // Update 1: Menerima List<Question> langsung, bukan Level/Subject
  final List<Question> questions;
  final String categoryName; // Tambahan biar judul AppBar cantik

  const QuizScreen({
    super.key, 
    required this.questions, 
    this.categoryName = "Kuis Seru", // Default title
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
    // Update 2: Tidak perlu filter lagi di sini, karena data sudah dikirim matang dari Home
    // Cukup acak soal biar urutannya beda-beda tiap main
    widget.questions.shuffle();
  }

  void _checkAnswer(int index) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      _selectedOptionIndex = index;
      if (index == widget.questions[_currentIndex].correctIndex) {
        _score += 10;
      }
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _isAnswered = false;
          _selectedOptionIndex = null;
        });
      } else {
        _showScoreDialog();
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Hore! Selesai!", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 60),
            const SizedBox(height: 10),
            Text("Nilai Kamu: $_score", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Tutup Dialog
              Navigator.pop(context); // Kembali ke Home
            },
            child: const Text("Main Lagi"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Update 3: Menggunakan widget.questions
    final currentQuestion = widget.questions[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Menampilkan nama kategori yang dikirim
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