import 'package:flutter/material.dart';
import 'package:icarus_core/pages/pagina02.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(title: "Icarus Core"),
    );
  }
}

class Inicio extends StatefulWidget {
  final String title;

  const Inicio({Key? key, required this.title}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.network(
              "https://img.freepik.com/vector-premium/icono-diseno-ilustraciones-logotipo-abeja_665655-11422.jpg?w=740",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 24),
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pagina02()),
              );
            },
            child: Text("ICARUS CORE", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
