import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
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
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FishInventoryScreen(),
                      ),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Manajemen Pakan',
                    Icons.restaurant,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedManagementScreen(),
                      ),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Monitoring Kesehatan',
                    Icons.health_and_safety,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HealthMonitoringScreen(),
                      ),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Data Pemberian Pakan',
                    Icons.restaurant_menu,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedingDataScreen(),
                      ),
                    ),
                  ),
                  _buildMonitoringCard(
                    context,
                    'Data Panen',
                    Icons.agriculture,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HarvestDataScreen(),
                      ),
                    ),
                  ),
                  // Sensor data feature removed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonitoringCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, [
    Color color = AppTheme.primaryGreen,
  ]) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
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

  // Sensor data UI removed
}
