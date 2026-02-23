import 'package:flutter/material.dart';

void main() {
  runApp(const QuilometragemApp());
}

class QuilometragemApp extends StatelessWidget {
  const QuilometragemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quilometragem do Rapha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTracking = false;
  bool isPaused = false;
  double totalDistance = 0.0;
  int elapsedSeconds = 0;

  void _startTracking() {
    setState(() {
      isTracking = true;
      isPaused = false;
      totalDistance = 0.0;
      elapsedSeconds = 0;
    });
  }

  void _pauseTracking() {
    setState(() {
      isPaused = true;
    });
  }

  void _resetTracking() {
    setState(() {
      isTracking = false;
      isPaused = false;
      totalDistance = 0.0;
      elapsedSeconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quilometragem do Rapha'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Quilometragem',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    '${totalDistance.toStringAsFixed(2)} km',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tempo',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    _formatTime(elapsedSeconds),
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: isTracking ? null : _startTracking,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              ElevatedButton.icon(
                onPressed: isTracking && !isPaused ? _pauseTracking : null,
                icon: const Icon(Icons.pause),
                label: const Text('Pausar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              ElevatedButton.icon(
                onPressed: isTracking ? _resetTracking : null,
                icon: const Icon(Icons.stop),
                label: const Text('Zerar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
