import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'latihan_tugas.dart'; // Impor file latihan tugas

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TugasModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Praktikum 3',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const LatihanTugasPage(),
    );
  }
}