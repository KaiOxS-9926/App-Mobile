import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

class MedicionInterfaz extends StatefulWidget {
  const MedicionInterfaz({Key? key}) : super(key: key);

  @override
  _MedicionInterfazState createState() => _MedicionInterfazState();
}

class _MedicionInterfazState extends State<MedicionInterfaz> {
  double output = 1234; // Simulated output in watts
  double efficiency = 85; // Simulated efficiency percentage
  double battery = 75; // Simulated battery percentage
  double dailyProduction = 5.4; // Simulated daily kWh

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startSimulation() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        output = (output + (10 - 5 * timer.tick % 3)).clamp(1000, 1500);
        efficiency = (efficiency + (1 - 0.5 * timer.tick % 3)).clamp(70, 95);
        battery = (battery + 0.1 * timer.tick).clamp(50, 100);
        dailyProduction = (dailyProduction + 0.01 * timer.tick).clamp(0, 10);
      });
    });
  }

  void _optimizeSystem() {
    setState(() {
      output = 1500;
      efficiency = 95;
      battery = 100;
      dailyProduction += 0.5; // Bonus production
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sistema Optimizado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
// Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      appBar: AppBar(
        title: Text('Medición de Energía'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.yellow.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/solar_background.png'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Panel de Control de Energía Solar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMetricCard(
                      'Salida (W)', output.toStringAsFixed(1), Icons.flash_on),
                  _buildMetricCard('Eficiencia (%)',
                      efficiency.toStringAsFixed(1), Icons.bar_chart),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: screenHeight *
                      0.3, // Make the chart take more vertical space
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(sampleData()),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMetricCard('Batería (%)', battery.toStringAsFixed(1),
                      Icons.battery_full),
                  _buildMetricCard('Diario (kWh)',
                      dailyProduction.toStringAsFixed(1), Icons.sunny),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _optimizeSystem,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Optimizar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                  height:
                      15), // Adds space to avoid the button sticking to the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      width:
          160, // Fixed width, you can adjust this if you want a more flexible layout
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.blueAccent),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  LineChartData sampleData() {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: Colors.orange,
          barWidth: 3,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.5),
                Colors.orange.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
