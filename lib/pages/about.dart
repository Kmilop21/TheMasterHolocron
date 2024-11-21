import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {

  

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Stack(
        children: <Widget>[
          // Imagen que cubre toda la pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/images/monkey.jpg', // Imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Contenido sobre la imagen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Yo',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 10, 9, 9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Texto',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 14, 14, 14),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Acción del botón
                  },
                  child: const Text('Volver'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

