import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'pantalla_login.dart';
import 'pantalla_registro.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  late VideoPlayerController controladorVideo;

  @override
  void initState() {
    super.initState();
    controladorVideo = VideoPlayerController.asset('assets/videos/fondo2.mp4')
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) {
        setState(() {});
        controladorVideo.setPlaybackSpeed(0.5);
        controladorVideo.play();
      });
  }

  @override
  void dispose() {
    controladorVideo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Kraizi World'),
        backgroundColor: const Color.fromARGB(255, 185, 97, 14),
      ),
      body: Stack(
        children: [
          if (controladorVideo.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controladorVideo.value.size.width,
                  height: controladorVideo.value.size.height,
                  child: VideoPlayer(controladorVideo),
                ),
              ),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMedievalButton(
                  context,
                  label: 'Iniciar sesión',
                  destination: const PantallaLogin(),
                ),
                const SizedBox(height: 30),
                _buildMedievalButton(
                  context,
                  label: 'Registrarse',
                  destination: const PantallaRegistro(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedievalButton(BuildContext context, {
    required String label,
    required Widget destination,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1C1C1C),
        foregroundColor: const Color(0xFFFFA500),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFFFA500), width: 2),
        ),
        elevation: 12,
        shadowColor: Colors.orangeAccent,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'MedievalSharp',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
