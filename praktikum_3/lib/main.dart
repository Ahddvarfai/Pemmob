import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tugas_belanja.dart'; // Mengarah ke file Tugas Daftar Belanja

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 3 - Tugas Belanja',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const BelanjaPage(),
    );
  }
}