import 'package:flutter/material.dart';
import 'package:icarus_core/pages/optimizar.dart';
import 'dart:async';
import 'package:icarus_core/pages/pagina03.dart';
import 'package:icarus_core/pages/medicion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Energía',
      home: Pagina04(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Pagina04 extends StatefulWidget {
  const Pagina04({Key? key}) : super(key: key);

  @override
  _Pagina04State createState() => _Pagina04State();
}

class _Pagina04State extends State<Pagina04> {
  int _currentIndex = 0;
  bool _isProcessing = false;
  String _processMessage = "Esperando acción...";

  final List<String> _titles = [
    "Medir la Energía",
    "Función para Optimizar",
    "Ayuda",
    "Cerrar Sesión"
  ];

  Future<void> _iniciarMedicion() async {
    setState(() {
      _isProcessing = true;
      _processMessage = "Iniciando medición de energía...";
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isProcessing = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicionInterfaz()),
    );
  }

  Future<void> _optimizarSistema() async {
    setState(() {
      _isProcessing = true;
      _processMessage = "Preparando optimización...";
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _processMessage = "Optimizando sistema energético...";
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isProcessing = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OptimizacionInterfaz()),
    );
  }

  void _mostrarAyuda() {
    setState(() {
      _processMessage = "Mostrando ayuda en pantalla.";
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ayuda"),
        content: Text(
          "Para soporte, por favor contacta al equipo técnico o consulta el manual en línea \n\nhttps://icarus.com/help \n\nTeléfono: +593-983233466",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  void _cerrarSesion() {
    setState(() {
      _processMessage = "Cerrando sesión...";
    });
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pagina03()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              "Mide tu consumo energético en tiempo real.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isProcessing ? null : _iniciarMedicion,
              child: Text("Iniciar Medición"),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.build, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Optimiza tu sistema energético con recomendaciones personalizadas.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isProcessing ? null : _optimizarSistema,
              child: Text("Optimizar"),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.help, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "¿Necesitas ayuda? Aquí encontrarás información y soporte.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _mostrarAyuda,
              child: Text("Consultar Ayuda"),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.exit_to_app, size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text(
              "¿Seguro que deseas cerrar sesión?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isProcessing ? null : _cerrarSesion,
              child: Text("Cerrar Sesión"),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Bienvenido, ${_titles[_currentIndex]}"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          if (_isProcessing)
            Column(
              children: [
                LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: Duration(seconds: 1),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Text(
                          _processMessage,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: "Medir Energía",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "Optimizar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Ayuda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: "Cerrar Sesión",
          ),
        ],
      ),
    );
  }
}
