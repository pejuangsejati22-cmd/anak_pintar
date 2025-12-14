import '../models/question_model.dart';

final List<Question> questionBank = [
  // ==============================
  // KATEGORI: PAUD
  // ==============================
  
  // --- PAUD MATEMATIKA ---
  Question(text: "Hitung jumlah jarimu!", options: ["2", "5", "10"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),
  Question(text: "Mana yang berbentuk bulat?", options: ["Bola", "Meja", "Buku"], correctIndex: 0, level: Level.paud, subject: Subject.matematika),
  Question(text: "Berapa kakinya ayam?", options: ["2", "4", "3"], correctIndex: 0, level: Level.paud, subject: Subject.matematika),
  Question(text: "Mana yang lebih besar?", options: ["Semut", "Gajah", "Kucing"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),
  Question(text: "Bentuk roda sepeda?", options: ["Kotak", "Bulat", "Segitiga"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),
  Question(text: "Angka 1 seperti apa?", options: ["Bebek", "Lidi", "Telur"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),
  Question(text: "Jumlah matamu ada?", options: ["1", "2", "3"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),
  Question(text: "Segitiga punya berapa sisi?", options: ["3", "4", "5"], correctIndex: 0, level: Level.paud, subject: Subject.matematika),
  Question(text: "Setelah angka 1 adalah?", options: ["3", "2", "4"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),
  Question(text: "Telinga kelinci?", options: ["Pendek", "Panjang", "Tidak ada"], correctIndex: 1, level: Level.paud, subject: Subject.matematika),

  // --- PAUD BAHASA ---
  Question(text: "Huruf awal 'AYAM'?", options: ["B", "C", "A"], correctIndex: 2, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Suara kucing?", options: ["Meong", "Guk guk", "Mbek"], correctIndex: 0, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Warna rumput?", options: ["Merah", "Hijau", "Biru"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Huruf awal 'BOLA'?", options: ["A", "B", "C"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Burung bisa?", options: ["Berenang", "Terbang", "Lari"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Warna langit cerah?", options: ["Hitam", "Biru", "Hijau"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Hidung untuk?", options: ["Melihat", "Mencium", "Makan"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Gigi untuk?", options: ["Mengunyah", "Berjalan", "Mendengar"], correctIndex: 0, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Huruf 'O' bentuknya?", options: ["Kotak", "Bulat", "Lurus"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),
  Question(text: "Sapi makan?", options: ["Daging", "Rumput", "Nasi"], correctIndex: 1, level: Level.paud, subject: Subject.bahasa),

  // ==============================
  // KATEGORI: TK
  // ==============================

  // --- TK MATEMATIKA ---
  Question(text: "1 + 2 = ...", options: ["3", "4", "5"], correctIndex: 0, level: Level.tk, subject: Subject.matematika),
  Question(text: "Urutan: 1, 2, ..., 4", options: ["5", "3", "6"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "2 + 2 = ...", options: ["3", "4", "5"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "5 - 1 = ...", options: ["3", "4", "6"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "Angka sebelum 10?", options: ["8", "9", "11"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "Jumlah jari satu tangan?", options: ["5", "10", "2"], correctIndex: 0, level: Level.tk, subject: Subject.matematika),
  Question(text: "3 + 0 = ...", options: ["0", "3", "30"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "Lebih banyak 5 atau 2?", options: ["2", "5", "Sama"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "Benda berbentuk kotak?", options: ["Bola", "Kardus", "Telur"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),
  Question(text: "4 + 3 = ...", options: ["6", "7", "8"], correctIndex: 1, level: Level.tk, subject: Subject.matematika),

  // --- TK BAHASA ---
  Question(text: "Lawan kata 'BESAR'?", options: ["Tinggi", "Kecil", "Luas"], correctIndex: 1, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Ibu dari Ayah disebut?", options: ["Tante", "Nenek", "Kakak"], correctIndex: 1, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Kita tidur di?", options: ["Dapur", "Kamar Tidur", "Kamar Mandi"], correctIndex: 1, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Lawan kata 'ATAS'?", options: ["Bawah", "Samping", "Kiri"], correctIndex: 0, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Sepatu dipakai di?", options: ["Tangan", "Kepala", "Kaki"], correctIndex: 2, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Matahari terbit saat?", options: ["Malam", "Pagi", "Sore"], correctIndex: 1, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Buku gunanya untuk?", options: ["Dibaca", "Dimakan", "Dilempar"], correctIndex: 0, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Topi dipakai di?", options: ["Lutut", "Kepala", "Perut"], correctIndex: 1, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Lawan kata 'PANAS'?", options: ["Dingin", "Hangat", "Pedas"], correctIndex: 0, level: Level.tk, subject: Subject.bahasa),
  Question(text: "Mobil rodanya ada?", options: ["2", "3", "4"], correctIndex: 2, level: Level.tk, subject: Subject.bahasa),

  // ==============================
  // KATEGORI: SD
  // ==============================

  // --- SD MATEMATIKA ---
  Question(text: "10 - 4 = ...", options: ["5", "6", "7"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "5 x 5 = ...", options: ["10", "20", "25"], correctIndex: 2, level: Level.sd, subject: Subject.matematika),
  Question(text: "15 + 15 = ...", options: ["20", "30", "40"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "100 dibagi 2 = ...", options: ["20", "50", "10"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "Sudut siku-siku besarnya?", options: ["45°", "90°", "180°"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "3 x 4 = ...", options: ["7", "12", "15"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "20 - 5 = ...", options: ["10", "15", "25"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "Bangun datar 3 sisi?", options: ["Persegi", "Segitiga", "Lingkaran"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "1 jam berapa menit?", options: ["100", "60", "30"], correctIndex: 1, level: Level.sd, subject: Subject.matematika),
  Question(text: "500 + 500 = ...", options: ["1000", "100", "5500"], correctIndex: 0, level: Level.sd, subject: Subject.matematika),

  // --- SD BAHASA ---
  Question(text: "Ibukota Indonesia?", options: ["Bandung", "Surabaya", "Jakarta"], correctIndex: 2, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Gabungan 'Mata' & 'Hari'?", options: ["Matahari", "Harimata", "Matari"], correctIndex: 0, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Antonim 'GELAP'?", options: ["Terang", "Malam", "Hitam"], correctIndex: 0, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Sinonim 'PINTAR'?", options: ["Bodoh", "Pandai", "Malas"], correctIndex: 1, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Hewan hidup di air & darat?", options: ["Mamalia", "Amfibi", "Unggas"], correctIndex: 1, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Presiden RI pertama?", options: ["Soeharto", "Soekarno", "Habibie"], correctIndex: 1, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Lagu kebangsaan kita?", options: ["Indonesia Raya", "Tanah Airku", "Garuda"], correctIndex: 0, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Rumah adat Padang?", options: ["Joglo", "Gadang", "Honai"], correctIndex: 1, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Bahasa Inggris 'PINTU'?", options: ["Door", "Window", "Table"], correctIndex: 0, level: Level.sd, subject: Subject.bahasa),
  Question(text: "Lambang sila pertama?", options: ["Bintang", "Rantai", "Pohon"], correctIndex: 0, level: Level.sd, subject: Subject.bahasa),

  // --- SD IPA ---
  Question(text: "Pusat tata surya adalah?", options: ["Bumi", "Bulan", "Matahari"], correctIndex: 2, level: Level.sd, subject: Subject.ipa),
  Question(text: "Hewan pemakan daging disebut?", options: ["Herbivora", "Karnivora", "Omnivora"], correctIndex: 1, level: Level.sd, subject: Subject.ipa),
  Question(text: "Tumbuhan bernapas melalui?", options: ["Akar", "Batang", "Daun (Stomata)"], correctIndex: 2, level: Level.sd, subject: Subject.ipa),
  Question(text: "Benda cair jika didinginkan jadi?", options: ["Uap", "Padat", "Gas"], correctIndex: 1, level: Level.sd, subject: Subject.ipa),
  Question(text: "Jantung berfungsi memompa?", options: ["Darah", "Udara", "Air"], correctIndex: 0, level: Level.sd, subject: Subject.ipa),
  Question(text: "Planet tempat kita tinggal?", options: ["Mars", "Bumi", "Jupiter"], correctIndex: 1, level: Level.sd, subject: Subject.ipa),
  Question(text: "Katak hidup di air dan darat disebut?", options: ["Reptil", "Amfibi", "Mamalia"], correctIndex: 1, level: Level.sd, subject: Subject.ipa),
  Question(text: "Indra penglihatan adalah?", options: ["Mata", "Hidung", "Telinga"], correctIndex: 0, level: Level.sd, subject: Subject.ipa),
  Question(text: "Air dipanaskan akan menjadi?", options: ["Es", "Uap", "Kristal"], correctIndex: 1, level: Level.sd, subject: Subject.ipa),
  Question(text: "Zat hijau pada daun disebut?", options: ["Klorofil", "Vitamin", "Protein"], correctIndex: 0, level: Level.sd, subject: Subject.ipa),

  // --- SD IPS ---
  Question(text: "Mata uang negara Indonesia?", options: ["Dollar", "Rupiah", "Ringgit"], correctIndex: 1, level: Level.sd, subject: Subject.ips),
  Question(text: "Pekerjaan yang mengobati pasien?", options: ["Guru", "Polisi", "Dokter"], correctIndex: 2, level: Level.sd, subject: Subject.ips),
  Question(text: "Manusia adalah makhluk?", options: ["Individu", "Sosial", "Egois"], correctIndex: 1, level: Level.sd, subject: Subject.ips),
  Question(text: "Alat transportasi udara?", options: ["Kapal", "Kereta", "Pesawat"], correctIndex: 2, level: Level.sd, subject: Subject.ips),
  Question(text: "Provinsi paling barat Indonesia?", options: ["Papua", "Bali", "Aceh"], correctIndex: 2, level: Level.sd, subject: Subject.ips),
  Question(text: "Lambang negara Indonesia?", options: ["Harimau", "Garuda", "Banteng"], correctIndex: 1, level: Level.sd, subject: Subject.ips),
  Question(text: "Kepala keluarga di rumah adalah?", options: ["Ibu", "Ayah", "Kakak"], correctIndex: 1, level: Level.sd, subject: Subject.ips),
  Question(text: "Ibukota Jawa Barat adalah?", options: ["Surabaya", "Bandung", "Semarang"], correctIndex: 1, level: Level.sd, subject: Subject.ips),
  Question(text: "Tempat menyimpan uang yang aman?", options: ["Bank", "Bawah Kasur", "Saku"], correctIndex: 0, level: Level.sd, subject: Subject.ips),
  Question(text: "Semboyan Bhinneka Tunggal Ika artinya?", options: ["Berbeda tetap satu", "Bersatu kita teguh", "Maju terus"], correctIndex: 0, level: Level.sd, subject: Subject.ips),
];