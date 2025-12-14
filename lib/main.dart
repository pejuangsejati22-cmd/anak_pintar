import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import Login Screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Edukasi Anak',
      
      // --- PENGATURAN TEMA GLOBAL ---
      theme: ThemeData(
        useMaterial3: true,
        // 1. Font Utama (Pastikan font ini terbaca di pubspec.yaml atau sistem)
        fontFamily: 'Arial Rounded MT Bold', 

        // 2. Skema Warna
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF), // Warna Ungu Utama
        
        ),

        // 3. Background Scaffold Global (Agar konsisten di semua layar)
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),

        // 4. Tema AppBar Global (Transparan & Teks Ungu)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.deepPurple), // Warna panah back
          titleTextStyle: TextStyle(
            fontFamily: 'Arial Rounded MT Bold',
            color: Colors.deepPurple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        // 5. Tema Tombol Global (Rounded & Ungu)
        // Ini membuat semua ElevatedButton otomatis jadi bulat dan ungu tanpa perlu di-style satu-satu
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF), // Warna tombol
            foregroundColor: Colors.white, // Warna teks
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial Rounded MT Bold',
            ),
          ),
        ),
      ),

      // --- TITIK MULAI APLIKASI ---
      // Ubah ke LoginScreen agar alurnya: Login -> Home -> Kuis
      home: const LoginScreen(), 
    );
  }
}