import 'package:flutter/material.dart';
import 'dart:async';
import '../models/question_model.dart';
import 'result_screen.dart'; 

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String categoryName;

  const QuizScreen({
    super.key,
    required this.questions,
    required this.categoryName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _isAnswerLocked = false;
  int? _selectedAnswerIndex;
  
  // Warna tema
  final Color _bgColor = const Color(0xFFFFF5E1);
  final Color _primaryColor = const Color(0xFF6C5CE7); 
  
  void _answerQuestion(int selectedIndex) {
    if (_isAnswerLocked) return;

    final question = widget.questions[_currentIndex];

    // --- PERBAIKAN 1: Langsung ambil property correctIndex ---
    int correctIndex = question.correctIndex; 
    // --------------------------------------------------------

    setState(() {
      _isAnswerLocked = true;
      _selectedAnswerIndex = selectedIndex;
    });

    bool isCorrect = selectedIndex == correctIndex;

    if (isCorrect) {
      _score++;
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      
      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _isAnswerLocked = false;
          _selectedAnswerIndex = null;
        });
      } else {
        _finishQuiz(); 
      }
    });
  }

  void _finishQuiz() {
    // Navigasi ke Halaman ResultScreen yang Premium
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _score,
          total: widget.questions.length,
          // Opsional: Kirim warna tema sesuai mata pelajaran jika mau
        ),
      ),
    );
  }

  // --- LOGIC WARNA TOMBOL ---
  Color _getButtonColor(int optionIndex) {
    if (!_isAnswerLocked) return Colors.white; 

    final question = widget.questions[_currentIndex];
    
    // --- PERBAIKAN 1 ---
    int correctIndex = question.correctIndex; 
    // -------------------

    if (optionIndex == correctIndex) {
      return const Color(0xFF00E676); // Hijau (Benar)
    }
    if (optionIndex == _selectedAnswerIndex && optionIndex != correctIndex) {
      return const Color(0xFFFF5252); // Merah (Salah pilih)
    }
    
    return Colors.grey[300]!; 
  }
  
  Color _getButtonShadow(int optionIndex) {
    if (!_isAnswerLocked) return Colors.grey[300]!;
    
    final question = widget.questions[_currentIndex];
    
    // --- PERBAIKAN 1 ---
    int correctIndex = question.correctIndex; 
    // -------------------
    
    if (optionIndex == correctIndex) return const Color(0xFF00B248); 
    if (optionIndex == _selectedAnswerIndex && optionIndex != correctIndex) return const Color(0xFFD50000); 
    
    return Colors.grey[400]!;
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentIndex];
    final double progress = (_currentIndex + 1) / widget.questions.length;

    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                "https://www.transparenttextures.com/patterns/cubes.png",
                repeat: ImageRepeat.repeat,
                errorBuilder: (c, o, s) => Container(),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Stack(
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD43B), 
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, offset: Offset(0, 10), blurRadius: 0)
                      ],
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Text(
                          // --- PERBAIKAN 2: Menggunakan .text sesuai model kamu ---
                          question.text, 
                          // --------------------------------------------------------
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                            fontFamily: 'Roboto', 
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Expanded(
                  flex: 3,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: question.options.length,
                    separatorBuilder: (ctx, idx) => const SizedBox(height: 16),
                    itemBuilder: (ctx, index) {
                      return _QuizOptionButton(
                        text: question.options[index],
                        color: _getButtonColor(index),
                        shadowColor: _getButtonShadow(index),
                        onTap: () => _answerQuestion(index),
                        isEnabled: !_isAnswerLocked,
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 4))],
              ),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.black, size: 24),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4))],
            ),
            child: Text(
              widget.categoryName.toUpperCase(),
              style: const TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w900, 
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 4))],
            ),
            child: Text(
              "${_currentIndex + 1}/${widget.questions.length}",
              style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Tombol Pilihan (Tetap sama)
class _QuizOptionButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color shadowColor;
  final VoidCallback onTap;
  final bool isEnabled;

  const _QuizOptionButton({
    required this.text,
    required this.color,
    required this.shadowColor,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  State<_QuizOptionButton> createState() => _QuizOptionButtonState();
}

class _QuizOptionButtonState extends State<_QuizOptionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.isEnabled ? widget.onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(0, _isPressed ? 6 : 0, 0),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
        child: Row(
          children: [
            Container(
              width: 12, height: 12,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.color == const Color(0xFF00E676) || widget.color == const Color(0xFFFF5252) 
                      ? Colors.white 
                      : Colors.black87, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}