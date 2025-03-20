import 'package:flutter/material.dart';
import 'package:icarus_core/pages/pagina03.dart';

class Pagina02 extends StatelessWidget {
  const Pagina02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Términos y Condiciones"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Términos y condiciones",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Bienvenido/a a Icarus Core (nosotros, nuestro o la Aplicación). Estos Términos y Condiciones regulan el acceso y uso de nuestra aplicación de optimización solar (en adelante, la App), que proporciona cálculos y recomendaciones relacionadas con sistemas solares fotovoltaicos. Al acceder o usar la App, aceptas estos Términos y Condiciones en su totalidad. Si no estás de acuerdo con alguno de los términos, debes abstenerte de utilizar la aplicación.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pagina03()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Acepto Todo", style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
