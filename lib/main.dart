import 'package:flutter/material.dart';
import 'patient_list.dart';

void main() {
  runApp(const NutrinovaApp());
}

class NutrinovaApp extends StatelessWidget {
  const NutrinovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutrinova',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFE8FBE5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF19B9D1),
        ),
        useMaterial3: true,
      ),
      home: const PatientPage(),
    );
  }
}