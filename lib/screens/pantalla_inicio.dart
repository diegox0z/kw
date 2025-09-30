import 'package:flutter/material.dart';
import '../drawer/drawer_personalizado.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      drawer: DrawerPersonalizado(),
      body: Center(child: Text('Bienvenido')),
    );
  }
}
