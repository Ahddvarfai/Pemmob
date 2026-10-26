import 'package:flutter/material.dart';

// 1. Model Data Kontak (nama, nomor telepon, email)
class Kontak {
  final String nama;
  final String telepon;
  final String email;
  const Kontak(this.nama, this.telepon, this.email);
}

// Minimal 6 data kontak
const daftarKontak = [
  Kontak('Ahmad Dava Rifai', '081234567890', 'ahmad.dava@email.com'),
  Kontak('Budi Santoso', '081398765432', 'budi.santoso@email.com'),
  Kontak('Citra Lestari', '082112345678', 'citra.lestari@email.com'),
  Kontak('Dewi Anggraini', '085698712345', 'dewi.anggraini@email.com'),
  Kontak('Eko Prasetyo', '087855443322', 'eko.prasetyo@email.com'),
  Kontak('Fajar Nugroho', '089611223344', 'fajar.nugroho@email.com'),
];

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // 2. Halaman utama menampilkan daftar kontak dengan ListView.builder
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];
          // Mengambil huruf pertama dari nama untuk ditampilkan di CircleAvatar
          final hurufPertama = kontak.nama.isNotEmpty ? kontak.nama[0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              // Avatar berisi huruf pertama nama (Diperbaiki tanpa typo tealStyle)
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade200,
                child: Text(
                  hurufPertama,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
              title: Text(kontak.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(kontak.telepon),
              trailing: const Icon(Icons.chevron_right),
              // 3. Mengetuk kontak membuka halaman detail
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailKontakPage(kontak: kontak),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman Detail Kontak
class DetailKontakPage extends StatelessWidget {
  final Kontak kontak;
  const DetailKontakPage({super.key, required this.kontak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kontak.nama),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar besar di halaman detail
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.teal.shade200,
                child: Text(
                  kontak.nama.isNotEmpty ? kontak.nama[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                kontak.nama,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(kontak.telepon, style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.email, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(kontak.email, style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}