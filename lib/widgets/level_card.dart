import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color; // Mengganti accentColor agar lebih umum
  final IconData icon; // Menambahkan parameter Icon agar bisa diganti-ganti
  final VoidCallback onTap;

  const LevelCard({
    super.key, 
    required this.title, 
    required this.subtitle, 
    required this.color, 
    required this.icon, // Wajib diisi
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Jarak antar kartu
      height: 120, // Tinggi tetap agar rapi
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4), // Bayangan berwarna sesuai kartu
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: Ink(
            // Dekorasi Gradient (Warna cerah ke agak gelap)
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.85), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // 1. Icon dalam Lingkaran Transparan
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Putih transparan
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 35, color: Colors.white),
                  ),
                  
                  const SizedBox(width: 20),
                  
                  // 2. Teks Judul & Subjudul
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 26, 
                            fontWeight: FontWeight.w900,
                            color: Colors.white, // Teks Putih agar kontras
                            fontFamily: 'Arial Rounded MT Bold', // Font bulat
                            letterSpacing: 1.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70, 
                            fontSize: 14, 
                            fontWeight: FontWeight.w500
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // 3. Icon Play (Panah)
                  const Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}