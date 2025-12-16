import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const MenuButton({
    super.key, 
    required this.title, 
    required this.subtitle,
    required this.icon, 
    required this.color, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // Membuat warna shadow otomatis lebih gelap dari warna dasar
    final Color shadowColor = HSLColor.fromColor(color).withLightness(0.4).toColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110, // Tinggi disesuaikan
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3), // Border Hitam Tebal (Ciri Khas Game)
          boxShadow: [
            BoxShadow(
              color: shadowColor, // Shadow Solid
              offset: const Offset(0, 8), // Efek Timbul 3D
              blurRadius: 0, // Tanpa Blur (Kartun Style)
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: Colors.white.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    // 1. Ikon Kiri (Dalam Lingkaran)
                    Container(
                      width: 55,
                      height: 55,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25), // Transparan Putih
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                      ),
                      child: Icon(icon, color: Colors.white, size: 28),
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
                              color: Colors.white,
                              fontSize: 24, 
                              fontWeight: FontWeight.w900, // Sangat Tebal
                              letterSpacing: 1.2,
                              // Shadow teks agar terbaca jelas
                              shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2))]
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 10),
                    
                    // 3. Tombol Play Kanan (Lingkaran Putih)
                    Container(
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
            ),
          ),
        ),
      ),
    );
  }
}