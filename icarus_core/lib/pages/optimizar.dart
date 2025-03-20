import 'package:flutter/material.dart';

class OptimizacionInterfaz extends StatefulWidget {
  const OptimizacionInterfaz({Key? key}) : super(key: key);

  @override
  _OptimizacionInterfazState createState() => _OptimizacionInterfazState();
}

class _OptimizacionInterfazState extends State<OptimizacionInterfaz> {
  double output = 1234; // Simulated output in watts
  double efficiency = 85; // Simulated efficiency percentage
  double battery = 75; // Simulated battery percentage
  double dailyProduction = 5.4; // Simulated daily kWh

  void _applyOptimization(String optimization) {
    setState(() {
      if (optimization == 'increaseOutput') {
        output = 1500;
      } else if (optimization == 'improveEfficiency') {
        efficiency = 95;
      } else if (optimization == 'maxBattery') {
        battery = 100;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Optimization applied: $optimization')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Optimización del Sistema'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2), // Espacio superior ajustable
                Text(
                  'Recomendaciones para Mejorar el Sistema',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildRecommendationCard(
                    'Aumentar Salida de Energía', 'increaseOutput', Icons.flash_on),
                _buildRecommendationCard(
                    'Mejorar Eficiencia del Sistema', 'improveEfficiency', Icons.bar_chart),
                _buildRecommendationCard(
                    'Maximizar Carga de Batería', 'maxBattery', Icons.battery_full),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _applyOptimization('increaseOutput');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Aplicar Optimización',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Aproveche las sugerencias para mejorar la eficiencia y la producción de energía.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String action, IconData icon) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.greenAccent),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.greenAccent),
        onTap: () => _applyOptimization(action),
      ),
    );
  }
}
