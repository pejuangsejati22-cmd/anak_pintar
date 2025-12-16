import 'package:flutter/material.dart';
// import 'home_screen.dart'; // Pastikan import ini ada jika ingin navigasi ke Home

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final Color? themeColor;

  const ResultScreen({
    super.key, 
    required this.score, 
    required this.total,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    // --- 1. LOGIKA SKOR & BINTANG (Diperbaiki ke Persentase) ---
    // Menghitung persentase agar kompatibel dengan input berapapun
    final int percentage = ((score / total) * 100).round();
    final bool isPassed = percentage >= 50;

    // Logika Bintang
    int stars = 0;
    if (percentage == 100) {
      stars = 3; // Sempurna
    } else if (percentage >= 80) {
      stars = 2; // Bagus
    } else if (percentage >= 50) {
      stars = 1; // Lulus
    }

    // Warna Tema Status
    final Color statusColor = isPassed ? const Color(0xFF00E676) : const Color(0xFFFF5252);
    final Color primaryColor = themeColor ?? const Color(0xFF6C5CE7);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1),
      body: Stack(
        children: [
          // Background Pattern
          const Positioned.fill(child: _GameBackgroundPattern()),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- HEADER TEKS ---
                  Text(
                    isPassed ? "MISSION COMPLETE" : "GAME OVER",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: isPassed ? const Color(0xFF00B894) : const Color(0xFFD63031),
                      letterSpacing: 2,
                      shadows: const [Shadow(color: Colors.black12, offset: Offset(2, 2))]
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 30),

                  // --- KARTU HASIL (GAME CARD STYLE) ---
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 10), // Hard Shadow
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // A. Bintang
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                index < stars ? Icons.star_rounded : Icons.star_border_rounded,
                                size: 55,
                                color: index < stars ? Colors.amber : Colors.grey[300],
                                shadows: index < stars 
                                  ? [const Shadow(color: Colors.orangeAccent, offset: Offset(0, 2), blurRadius: 2)]
                                  : [],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 25),

                        // B. Ikon Utama (Piala / Tengkorak)
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: statusColor, width: 3),
                          ),
                          child: Icon(
                            isPassed ? Icons.emoji_events_rounded : Icons.sentiment_very_dissatisfied_rounded,
                            size: 80,
                            color: statusColor,
                          ),
                        ),
                        
                        const SizedBox(height: 25),

                        // C. Skor Digital
                        Text(
                          "SCORE",
                          style: TextStyle(
                            fontSize: 14, 
                            fontWeight: FontWeight.w900, 
                            color: Colors.grey[600],
                            letterSpacing: 2
                          ),
                        ),
                        Text(
                          "$percentage", // Menampilkan nilai 0-100
                          style: TextStyle(
                            fontSize: 60, 
                            fontWeight: FontWeight.w900, 
                            color: statusColor,
                            height: 1,
                          ),
                        ),
                        Text(
                          "($score dari $total Benar)",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[500]),
                        ),
                        
                        const SizedBox(height: 25),

                        // D. Pesan Motivasi
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[300]!, width: 2),
                          ),
                          child: Text(
                            isPassed 
                              ? "Kerja bagus! Kamu siap untuk level berikutnya." 
                              : "Jangan menyerah! Coba lagi untuk meraih bintang.",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- TOMBOL NAVIGASI ---
                  Row(
                    children: [
                      // Tombol Home (Kecil)
                      Expanded(
                        flex: 1,
                        child: _Game3DButton(
                          color: Colors.white,
                          shadowColor: Colors.grey[400]!,
                          borderColor: Colors.black,
                          child: const Icon(Icons.home_rounded, color: Colors.black),
                          onTap: () {
                             Navigator.popUntil(context, (route) => route.isFirst);
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      
                      // Tombol Selesai (Besar)
                      Expanded(
                        flex: 3,
                        child: _Game3DButton(
                          label: "SELESAI",
                          color: primaryColor,
                          shadowColor: Colors.black26, // Shadow gelap karena warnanya pekat
                          onTap: () {
                             Navigator.popUntil(context, (route) => route.isFirst);
                          },
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

// --- WIDGET REUSABLE (Agar file mandiri & tidak error) ---

// 1. Tombol 3D
class _Game3DButton extends StatefulWidget {
  final Color color;
  final Color shadowColor;
  final Color? borderColor;
  final String? label;
  final Widget? child;
  final VoidCallback onTap;

  const _Game3DButton({
    required this.color,
    required this.shadowColor,
    this.borderColor,
    this.label,
    this.child,
    required this.onTap,
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
        height: 55,
        transform: Matrix4.translationValues(0, _isPressed ? 6 : 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.borderColor ?? Colors.black, width: 2),
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
        child: widget.child ?? Text(
          widget.label ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

// 2. Background Pattern
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
            top: -50, left: -50,
            child: Icon(Icons.celebration, size: 150, color: Colors.blue.withOpacity(0.05)),
          ),
          Positioned(
            bottom: 50, right: -20,
            child: Icon(Icons.star, size: 120, color: Colors.orange.withOpacity(0.1)),
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