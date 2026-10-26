import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Model Data Belanja
class BarangBelanja {
  String nama;
  int jumlah;
  String kategori;
  bool dibeli;

  BarangBelanja({
    required this.nama,
    required this.jumlah,
    required this.kategori,
    this.dibeli = false,
  });
}

// State Management dengan ChangeNotifier
class BelanjaModel extends ChangeNotifier {
  final List<BarangBelanja> _items = [];

  List<BarangBelanja> get items => List.unmodifiable(_items);
  int get jumlahBelumDibeli => _items.where((b) => !b.dibeli).length;

  void tambah(String nama, int jumlah, String kategori) {
    _items.add(BarangBelanja(nama: nama, jumlah: jumlah, kategori: kategori));
    notifyListeners();
  }

  void toggleDibeli(int index) {
    _items[index].dibeli = !_items[index].dibeli;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

// Halaman Daftar Belanja
class BelanjaPage extends StatelessWidget {
  const BelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Belanja (Belum Dibeli: ${model.jumlahBelumDibeli})'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Belum ada barang belanjaan',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, i) {
          final barang = model.items[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Checkbox(
                value: barang.dibeli,
                onChanged: (_) => context.read<BelanjaModel>().toggleDibeli(i),
              ),
              title: Text(
                barang.nama,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: barang.dibeli ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text('Jumlah: ${barang.jumlah} | Kategori: ${barang.kategori}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => context.read<BelanjaModel>().hapus(i),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahBarangPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Halaman Form Tambah Barang dengan Validasi
class TambahBarangPage extends StatefulWidget {
  const TambahBarangPage({super.key});

  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  String? _kategori;

  final List<String> _listKategori = ['Makanan', 'Minuman', 'Elektronik', 'Lainnya'];

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text.trim();
      final jumlah = int.parse(_jumlahController.text.trim());
      final kategori = _kategori ?? 'Lainnya';

      context.read<BelanjaModel>().tambah(nama, jumlah, kategori);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Barang berhasil ditambahkan!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang Belanja'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama barang wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Jumlah wajib diisi';
                final angka = int.tryParse(v);
                if (angka == null || angka <= 0) return 'Jumlah harus berupa angka lebih dari 0';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _listKategori.map((kat) {
                return DropdownMenuItem(value: kat, child: Text(kat));
              }).toList(),
              onChanged: (v) => setState(() => _kategori = v),
              validator: (v) => v == null ? 'Pilih kategori barang' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _simpan,
              child: const Text('Simpan Barang', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}