import 'package:flutter/material.dart';
import 'package:icarus_core/database/db.dart';
import 'package:icarus_core/pages/pagina04.dart';
import 'package:icarus_core/pages/pagina05.dart';

void main() => runApp(Pagina03());

class Pagina03 extends StatelessWidget {
  const Pagina03({Key? key}) : super(key: key);

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
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: cuerpo(),
    );
  }

  Widget cuerpo() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://img.freepik.com/fotos-premium/fondo-degradado-amarillo-fondo-borroso-amarillo-fondo-pantalla-degradado-pastel-amarillo_613001-6578.jpg?semt=ais_hybrid"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Image.network(
                "https://img.freepik.com/vector-premium/icono-diseno-ilustraciones-logotipo-abeja_665655-11422.jpg?w=740",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30),
            campoTexto("User", _userController),
            SizedBox(height: 15),
            campoTexto("Password", _passwordController, obscureText: true),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pagina05()),
                    );
                  },
                  child:
                      Text("Register", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 20), // Espacio entre los botones
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    validarCredenciales(context);
                  },
                  child: Text("Sign in", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget campoTexto(String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  void validarCredenciales(BuildContext context) async {
    String user = _userController.text.trim();
    String password = _passwordController.text.trim();

    if (user.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Por favor llena todos los campos"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final isValid = await DatabaseHelper.instance.validateUser(user, password);

    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pagina04()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario o contraseña incorrectos"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
