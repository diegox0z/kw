import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  bool _aceptaTerminos = false;
  bool _cargando = false;

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  Future<void> _registrarUsuario() async {
    setState(() => _cargando = true);

    try {
      // Crear usuario en Firebase Authentication
      UserCredential credenciales = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _correoController.text.trim(),
        password: _contrasenaController.text.trim(),
      );

      // Guardar datos adicionales en Firestore
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(credenciales.user!.uid)
          .set({
        'usuario': _usuarioController.text.trim(),
        'correo': _correoController.text.trim(),
        'aceptaTerminos': _aceptaTerminos,
        'fechaRegistro': Timestamp.now(),
      });

      // Mostrar éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );

      // Limpiar formulario
      _usuarioController.clear();
      _correoController.clear();
      _contrasenaController.clear();
      setState(() => _aceptaTerminos = false);
    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error al registrar';
      if (e.code == 'email-already-in-use') {
        mensaje = 'Este correo ya está registrado';
      } else if (e.code == 'weak-password') {
        mensaje = 'La contraseña es demasiado débil';
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
        title: const Text('Registro'),
        backgroundColor: const Color.fromARGB(255, 185, 97, 14),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Crea tu cuenta',
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
                controller: _usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Introduce tu nombre de usuario' : null,
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 20),

              CheckboxListTile(
                title: const Text('Acepto los términos de uso'),
                value: _aceptaTerminos,
                onChanged: (value) => setState(() => _aceptaTerminos = value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
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
                          if (!_aceptaTerminos) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Debes aceptar los términos de uso')),
                            );
                            return;
                          }
                          _registrarUsuario();
                        }
                      },
                child: _cargando
                    ? const CircularProgressIndicator(color: Colors.orangeAccent)
                    : const Text(
                        'Registrarse',
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
