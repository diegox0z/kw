import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  bool _cargando = false;

  Future<void> _iniciarSesion() async {
    setState(() => _cargando = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _correoController.text.trim(),
        password: _contrasenaController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión exitoso')),
      );

      // Aquí puedes navegar a la pantalla principal
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PantallaInicio()));
    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error al iniciar sesión';
      if (e.code == 'user-not-found') {
        mensaje = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        mensaje = 'Contraseña incorrecta';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $e')),
      );
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        backgroundColor: const Color.fromARGB(255, 185, 97, 14),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Bienvenido de nuevo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MedievalSharp',
                  color: Colors.orangeAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || !value.contains('@') ? 'Introduce un correo válido' : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _contrasenaController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C1C1C),
                  foregroundColor: const Color(0xFFFFA500),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFFFA500), width: 2),
                  ),
                  elevation: 12,
                  shadowColor: Colors.orangeAccent,
                ),
                onPressed: _cargando
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _iniciarSesion();
                        }
                      },
                child: _cargando
                    ? const CircularProgressIndicator(color: Colors.orangeAccent)
                    : const Text(
                        'Entrar',
                        style: TextStyle(
                          fontFamily: 'MedievalSharp',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
