import 'package:flutter/material.dart';
import '../models/pond.dart';

class PondDetailScreen extends StatelessWidget {
  final Pond pond;

  const PondDetailScreen({super.key, required this.pond});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pond.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: pond.id,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.pool, size: 80, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Nama: ${pond.name}', style: const TextStyle(fontSize: 18)),
            Text('Panjang: ${pond.length} m'),
            Text('Lebar: ${pond.width} m'),
            Text('Kedalaman: ${pond.depth} m'),
            Text('Volume: ${pond.volume.toStringAsFixed(2)} m³'),
            Text('Status: ${pond.status}'),
            const SizedBox(height: 32),
            const Text('Kualitas Air', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // Add quality data here
            const SizedBox(height: 16),
            const Text('Sampling', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // Add sampling data here
          ],
        ),
      ),
    );
  }
}