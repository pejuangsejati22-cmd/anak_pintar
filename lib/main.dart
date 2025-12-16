import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; 

void main() {
  // Pastikan binding diinisialisasi (Penting karena kita pakai Database)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Edukasi Anak',
      
      // --- PENGATURAN TEMA PREMIUM GAME ---
      theme: ThemeData(
        useMaterial3: true,
        // Gunakan font default, tapi kita pertebal di style
        fontFamily: 'Roboto', 
        fontFamilyFallback: const ['Arial', 'sans-serif'],

        // 1. Skema Warna Game (Ungu & Cream)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7), // Ungu Game
          surface: const Color(0xFFFFF5E1), // Background Cream Hangat (Sama seperti Login/Home)
          onSurface: Colors.black87,
        ),

        // 2. Background Global
        scaffoldBackgroundColor: const Color(0xFFFFF5E1),

        // 3. Tema AppBar Global
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // Ikon Back Hitam Tebal
          iconTheme: IconThemeData(color: Colors.black, size: 28), 
          titleTextStyle: TextStyle(
            color: Colors.black, // Judul Hitam
            fontSize: 24,
            fontWeight: FontWeight.w900, // Font Sangat Tebal (Game Style)
            letterSpacing: 1.5,
          ),
        ),

        // 4. Tema Tombol Global (Untuk Dialog/System)
        // Agar tombol standar pun punya Border Hitam ala Game
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C5CE7), // Ungu
            foregroundColor: Colors.white,
            elevation: 0, // Hilangkan shadow blur standar (Kita pakai hard shadow di custom widget)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.black, width: 2), // Border Hitam
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w900, // Teks Tebal
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ),

        // 5. Tema Input Text Global
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F6FA),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 3),
          ),
        ),
      ),

      // --- TITIK MULAI ---
      home: const LoginScreen(), 
    );
  }
}