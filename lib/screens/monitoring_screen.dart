import 'package:flutter/material.dart';
import 'fish_inventory_screen.dart';
import 'feed_management_screen.dart';
import 'health_monitoring_screen.dart';
import 'feeding_data_screen.dart';
import 'harvest_data_screen.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Kategori Monitoring',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMonitoringCard(
                    context,
                    'Inventory Ikan',
                    Icons.inventory,
                    Colors.blue,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FishInventoryScreen()),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Manajemen Pakan',
                    Icons.restaurant,
                    Colors.green,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedManagementScreen()),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Monitoring Kesehatan',
                    Icons.health_and_safety,
                    Colors.orange,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HealthMonitoringScreen()),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Data Pemberian Pakan',
                    Icons.restaurant_menu,
                    Colors.teal,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedingDataScreen()),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Data Panen',
                    Icons.agriculture,
                    Colors.purple,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HarvestDataScreen()),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Sensor Data',
                    Icons.sensors,
                    Colors.red,
                    () => _showSensorData(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonitoringCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSensorData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sensor Data'),
        content: const Text('Fitur sensor data akan ditampilkan di sini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}