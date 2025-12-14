import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color; // Ubah dari List<Color> jadi Color tunggal biar mudah dipanggil
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
    return Container(
      // Margin disesuaikan agar rapi
      margin: const EdgeInsets.only(bottom: 20), 
      height: 120, // Tinggi tetap agar semua tombol seragam
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), // Radius 25 biar lebih bulat (ramah anak)
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4), // Bayangan mengikuti warna tombol
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        // Gradasi otomatis dibuat dari satu warna
        gradient: LinearGradient(
          colors: [color.withOpacity(0.85), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                // Icon Kiri (Dalam lingkaran transparan)
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 30),
                ),
                
                const SizedBox(width: 20),
                
                // Bagian Teks
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Font agak besar
                          fontWeight: FontWeight.w900, // Lebih tebal
                          letterSpacing: 1,
                          fontFamily: 'Arial Rounded MT Bold', // Font tema game
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 10),
                
                // Icon Kanan (Play Button biar lebih seru)
                const Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}