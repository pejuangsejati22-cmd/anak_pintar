import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const LevelCard({
    super.key, 
    required this.title, 
    required this.subtitle, 
    required this.color, 
    required this.icon, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // Menghitung warna shadow (sedikit lebih gelap dari warna dasar)
    final Color shadowColor = HSLColor.fromColor(color).withLightness(0.4).toColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3), // Border Kartun Tebal
          boxShadow: [
            BoxShadow(
              color: shadowColor, // Shadow Solid (Hard Shadow)
              offset: const Offset(0, 8), // Geser ke bawah untuk efek 3D
              blurRadius: 0, // Tanpa blur
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            
            // 1. Icon dalam Lingkaran Transparan
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // Menggunakan withOpacity agar aman untuk semua versi Flutter
                color: Colors.white.withOpacity(0.25), 
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
              ),
              child: Icon(icon, size: 32, color: Colors.white),
            ),
            
            const SizedBox(width: 20),
            
            // 2. Teks Judul & Subjudul
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.w900, // Font Sangat Tebal
                      color: Colors.white,
                      letterSpacing: 1.5,
                      // Shadow teks tipis agar terbaca jelas
                      shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2))]
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 13, 
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // 3. Tombol Play Putih
            Container(
              margin: const EdgeInsets.only(right: 20, left: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 3))],
              ),
              child: Icon(Icons.play_arrow_rounded, color: color, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}