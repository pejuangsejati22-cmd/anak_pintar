import 'package:flutter/material.dart';

// ==============================
// ENUMS DENGAN "POWER-UPS" (EXTENSIONS)
// ==============================

enum Level { paud, tk, sd }

// Extension: Agar Level punya nama tampilan yang cantik
extension LevelExtension on Level {
  String get displayName {
    switch (this) {
      case Level.paud: return "PAUD";
      case Level.tk: return "TK";
      case Level.sd: return "SD / MI";
    }
  }
}

enum Subject { matematika, bahasa, ipa, ips }

// Extension: Agar Subject otomatis tahu Warna & Ikon-nya sendiri
extension SubjectExtension on Subject {
  // Nama Tampilan
  String get displayName {
    switch (this) {
      case Subject.matematika: return "MATEMATIKA";
      case Subject.bahasa: return "BAHASA";
      case Subject.ipa: return "IPA";
      case Subject.ips: return "IPS";
    }
  }

  // Warna Tema Game per Pelajaran
  Color get color {
    switch (this) {
      case Subject.matematika: return const Color(0xFF4ECDC4); // Tosca Game
      case Subject.bahasa: return const Color(0xFFFF6B6B); // Coral Red
      case Subject.ipa: return const Color(0xFF6C5CE7); // Purple Game
      case Subject.ips: return const Color(0xFFFFA502); // Orange Game
    }
  }

  // Ikon 3D
  IconData get icon {
    switch (this) {
      case Subject.matematika: return Icons.calculate_rounded;
      case Subject.bahasa: return Icons.abc_rounded;
      case Subject.ipa: return Icons.biotech_rounded;
      case Subject.ips: return Icons.public_rounded;
    }
  }
}

// ==============================
// MODEL UTAMA
// ==============================

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final Level level;
  final Subject subject;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.level,
    required this.subject,
  });
}