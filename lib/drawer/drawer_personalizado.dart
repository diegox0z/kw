import 'package:flutter/material.dart';

class DrawerPersonalizado extends StatelessWidget {
  const DrawerPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Sir Galahad'),
            accountEmail: Text('Nivel 12 - Paladín'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventario'),
            onTap: () {
              Navigator.pushNamed(context, '/inventario');
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Misiones'),
            onTap: () {
              Navigator.pushNamed(context, '/misiones');
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Mapa'),
            onTap: () {
              Navigator.pushNamed(context, '/mapa');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              // Aquí podrías agregar lógica para cerrar sesión
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
