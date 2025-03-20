import 'package:flutter/material.dart';
import 'package:icarus_core/database/db.dart';

class Pagina05 extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            campoTexto("Username", controller: userController),
            SizedBox(height: 15),
            campoTexto("Password",
                obscureText: true, controller: passwordController),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                final username = userController.text.trim();
                final password = passwordController.text.trim();

                if (username.isNotEmpty && password.isNotEmpty) {
                  await DatabaseHelper.instance
                      .registerUser(username, password);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Usuario registrado con éxito")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Por favor llena todos los campos"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget campoTexto(String label,
      {bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
