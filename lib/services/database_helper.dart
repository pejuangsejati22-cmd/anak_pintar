import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // PENTING: Untuk deteksi Web

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter Database
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    // PENGAMAN 1: Jika di Web, jangan inisialisasi database!
    if (kIsWeb) {
      throw Exception("Mode Web tidak mendukung Database SQLite Lokal.");
    }

    _database = await _initDB('game_edukasi.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        email TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        level TEXT NOT NULL,
        category TEXT NOT NULL,
        score INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  // --- FUNGSI CRUD (DENGAN PENGAMAN WEB) ---

  // 1. Daftar User
  Future<bool> registerUser(String name, String email, String password) async {
    // BYPASS WEB: Langsung return True (Berhasil)
    if (kIsWeb) {
      print("[WEB MODE] Pura-pura mendaftar: $email");
      return true; 
    }

    // ANDROID: Jalankan normal
    final db = await instance.database;
    try {
      await db.insert('users', {'email': email, 'name': name, 'password': password});
      return true;
    } catch (e) {
      return false;
    }
  }

  // 2. Login User
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    // BYPASS WEB: Langsung return Data Palsu
    if (kIsWeb) {
      print("[WEB MODE] Pura-pura login: $email");
      // Kita kembalikan data user bohongan biar bisa masuk Home
      return {
        'email': email,
        'name': 'Guys', 
        'password': password
      };
    }

    // ANDROID: Cek database beneran
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // 3. Simpan Nilai
  Future<void> saveScore(String email, String level, String category, int score) async {
    // BYPASS WEB: Cuma print log
    if (kIsWeb) {
      print("[WEB MODE] Skor $score (Tidak disimpan permanen)");
      return;
    }

    // ANDROID: Simpan permanen
    final db = await instance.database;
    await db.insert('scores', {
      'user_email': email,
      'level': level,
      'category': category,
      'score': score,
      'date': DateTime.now().toIso8601String(),
    });
  }
}