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
              'assets/images/dogs.jpg', // Imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Contenido sobre la imagen
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Creadores',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '-Camilo Provoste',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 240, 240, 240),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  '-Diego Morales',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 248, 248, 248),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

