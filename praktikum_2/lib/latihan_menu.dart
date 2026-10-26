import 'package:flutter/material.dart';

// Model Data Makanan dengan Deskripsi (Latihan Mandiri No. 2)
class MakananLatihan {
  final String nama;
  final int harga;
  final String deskripsi;
  const MakananLatihan(this.nama, this.harga, this.deskripsi);
}

// Fungsi format harga ribuan (Latihan Mandiri No. 4)
String formatRupiah(int angka) {
  return angka.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
  );
}

// Daftar 7 Menu (4 menu asli + 3 menu baru - Latihan Mandiri No. 1)
const daftarMenuLatihan = [
  MakananLatihan('Nasi Goreng', 15000, 'Nasi goreng spesial dengan tambahan telur dan suwiran ayam.'),
  MakananLatihan('Mie Ayam', 12000, 'Mie kenyal dengan topping ayam gurih dan kuah kaldu hangat.'),
  MakananLatihan('Es Teh', 4000, 'Teh manis segar disajikan dengan es batu.'),
  MakananLatihan('Ayam Bakar', 20000, 'Ayam bumbu kecap manis dibakar dengan aroma khas.'),
  MakananLatihan('Bakso Sapi', 13000, 'Bakso daging sapi asli dengan kuah kaldu sapi bening yang sedap.'),
  MakananLatihan('Sate Ayam', 18000, 'Sate daging ayam dengan bumbu kacang kental dan lontong.'),
  MakananLatihan('Es Jeruk', 5000, 'Perasan buah jeruk segar pilihan dengan tambahan gula asli dan es.'),
];

class LatihanMenuPage extends StatelessWidget {
  const LatihanMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latihan Mandiri Menu')),
      body: ListView.builder(
        itemCount: daftarMenuLatihan.length,
        itemBuilder: (context, index) {
          final item = daftarMenuLatihan[index];
          // Mengganti Card dengan Container melengkung (Latihan Mandiri No. 3)
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
                leading: const Icon(Icons.restaurant, color: Colors.blue),
                title: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Rp ${formatRupiah(item.harga)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailLatihanPage(makanan: item),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailLatihanPage extends StatelessWidget {
  final MakananLatihan makanan;
  const DetailLatihanPage({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makanan.nama)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.restaurant_menu, size: 80, color: Colors.blue),
              const SizedBox(height: 16),
              Text(makanan.nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Rp ${formatRupiah(makanan.harga)}', style: const TextStyle(fontSize: 18, color: Colors.green)),
              const SizedBox(height: 16),
              Text(
                makanan.deskripsi,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
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