import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/pantalla_inicio.dart';
import 'firebase_options.dart'; // Este archivo lo genera flutterfire configure

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
