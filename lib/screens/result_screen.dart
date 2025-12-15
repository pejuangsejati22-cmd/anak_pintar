import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total; // Jumlah soal
  final Color? themeColor;

  const ResultScreen({
    super.key, 
    required this.score, 
    required this.total,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Logika Nilai
    // Kita asumsikan 1 soal = 10 poin. Jadi Nilai Maksimal = Total Soal * 10.
    int maxScore = total * 10;
    
    // Lulus jika nilai minimal 50% dari total
    bool isPassed = score >= (maxScore / 2);

    // 2. Logika Bintang (0 - 3 Bintang)
    int stars = 0;
    if (score == maxScore) {
      stars = 3; // Sempurna
    } else if (score >= (maxScore * 0.7)) {
      stars = 2; // Bagus
    } else if (score >= (maxScore * 0.4)) {
      stars = 1; // Lumayan
    }
    // Jika di bawah itu, stars tetap 0

    Color primaryColor = themeColor ?? const Color(0xFF6C63FF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(), // Background dekoratif
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kartu Hasil
                  Card(
                    elevation: 10,
                    // PERBAIKAN: Menggunakan withValues
                    shadowColor: primaryColor.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // A. Tampilan Bintang
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return Icon(
                                index < stars ? Icons.star_rounded : Icons.star_border_rounded,
                                size: 50,
                                color: Colors.amber,
                              );
                            }),
                          ),
                          const SizedBox(height: 20),

                          // B. Ikon Besar (Piala / Sedih)
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              // PERBAIKAN: Menggunakan withValues
                              color: isPassed 
                                  ? Colors.green.withValues(alpha: 0.1) 
                                  : Colors.red.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPassed ? Icons.emoji_events_rounded : Icons.mood_bad_rounded,
                              size: 80,
                              color: isPassed ? Colors.green : Colors.redAccent,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // C. Teks Ucapan
                          Text(
                            isPassed ? "Luar Biasa!" : "Jangan Menyerah!",
                            style: TextStyle(
                              fontSize: 28, 
                              fontWeight: FontWeight.bold, 
                              color: primaryColor,
                              fontFamily: 'Arial Rounded MT Bold',
                              // Tambahan: Fallback font agar aman
                              fontFamilyFallback: ['Roboto', 'sans-serif'],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isPassed ? "Kamu berhasil menyelesaikan kuis." : "Ayo coba belajar lagi ya!",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),

                          // D. Kotak Skor
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Text("SKOR KAMU", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                                Text(
                                  "$score",
                                  style: TextStyle(
                                    fontSize: 48, 
                                    fontWeight: FontWeight.w900, 
                                    color: isPassed ? Colors.blueAccent : Colors.redAccent
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Tombol Kembali ke Menu
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Kembali ke halaman paling awal (Home)
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        // PERBAIKAN: Menggunakan withValues
                        shadowColor: primaryColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      icon: const Icon(Icons.home_rounded, size: 28),
                      label: const Text(
                        "KEMBALI KE MENU", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                ],
              ),
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
            top: -60, left: -60,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 120, backgroundColor: Colors.blueAccent.withValues(alpha: 0.1)),
          ),
          Positioned(
            bottom: -40, right: -40,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 100, backgroundColor: Colors.orangeAccent.withValues(alpha: 0.1)),
          ),
          Positioned(
            top: 100, right: 30,
            // PERBAIKAN: Menggunakan withValues
            child: CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent.withValues(alpha: 0.1)),
          ),
        ],
      ),
    );
  }
}