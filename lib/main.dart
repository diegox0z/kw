import 'package:flutter/material.dart';
import 'screens/pantalla_inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kraizi World',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'MedievalSharp',
      ),
      home: const PantallaInicio(),
    );
  }
}
