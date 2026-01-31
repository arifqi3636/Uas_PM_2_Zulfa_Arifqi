import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/pond_provider.dart';
import '../providers/fish_inventory_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/health_provider.dart';
import '../providers/feeding_provider.dart';
import '../providers/harvest_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PondProvider>(context, listen: false).loadPonds();
      Provider.of<FishInventoryProvider>(
        context,
        listen: false,
      ).loadInventories();
      Provider.of<FeedProvider>(context, listen: false).loadFeeds();
      Provider.of<HealthProvider>(context, listen: false).loadMonitorings();
      Provider.of<FeedingProvider>(context, listen: false).loadFeedings();
      Provider.of<HarvestProvider>(context, listen: false).loadHarvests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pondProvider = Provider.of<PondProvider>(context);
    final fishProvider = Provider.of<FishInventoryProvider>(context);
    final feedProvider = Provider.of<FeedProvider>(context);
    final healthProvider = Provider.of<HealthProvider>(context);
    final feedingProvider = Provider.of<FeedingProvider>(context);
    final harvestProvider = Provider.of<HarvestProvider>(context);

    final ponds = pondProvider.ponds;
    final fish = fishProvider.inventories;
    final feeds = feedProvider.feeds;
    final monitorings = healthProvider.monitorings;
    final feedings = feedingProvider.feedings;
    final harvests = harvestProvider.harvests;

    // Calculate statistics
    int totalPonds = ponds.length;
    int healthyPonds = ponds.where((p) => p.status == 'healthy').length;
    int moderatePonds = ponds.where((p) => p.status == 'moderate').length;
    int unhealthyPonds = ponds.where((p) => p.status == 'unhealthy').length;

    int totalFish = fish.fold(0, (sum, f) => sum + f.quantity);
    double totalFishWeight = fish.fold(
      0.0,
      (sum, f) => sum + (f.averageWeight * f.quantity),
    );
    double averageFishWeight = totalFish > 0 ? totalFishWeight / totalFish : 0;

    double totalFeedStock = feeds.fold(0.0, (sum, f) => sum + f.quantity);
    double totalFeedValue = feeds.fold(
      0.0,
      (sum, f) => sum + (f.quantity * f.price),
    );

    int totalHealthRecords = monitorings.length;
    int healthyRecords = monitorings
        .where((m) => m.status == 'Normal' || m.status == 'Baik')
        .length;
    int unhealthyRecords = monitorings.where((m) => m.status == 'Buruk').length;

    // total feed given computed when needed; remove unused local variable
    double totalHarvestWeight = harvests.fold(0.0, (sum, h) => sum + h.weight);
    double totalHarvestValue = harvests.fold(
      0.0,
      (sum, h) => sum + (h.weight * h.pricePerKg),
    );

    // Calculate alerts
    List<String> alerts = [];
    if (unhealthyPonds > 0) {
      alerts.add('$unhealthyPonds kolam dalam kondisi tidak sehat');
    }
    if (unhealthyRecords > 0) {
      alerts.add('$unhealthyRecords catatan kesehatan menunjukkan masalah');
    }
    if (totalFeedStock < 100) {
      alerts.add('Stok pakan rendah: ${totalFeedStock.toStringAsFixed(1)} kg');
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryGreen, AppTheme.accentGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Dashboard'),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // use theme primary and a softer primary container
                        // the actual runtime colors resolve from Theme
                        Color(0xFF2E7D32),
                        Color(0xFFA5D6A7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.dashboard, size: 80, color: Colors.white),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Show alerts
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Sistem',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pond Statistics
                    Row(
                      children: [
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _animation.value,
                                child: _buildSummaryCard(
                                  'Total Kolam',
                                  totalPonds.toString(),
                                  Icons.water_drop,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _animation.value,
                                child: _buildSummaryCard(
                                  'Kolam Sehat',
                                  healthyPonds.toString(),
                                  Icons.check_circle,
                                  color: AppTheme.statusHealthy,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Kolam Moderat',
                            moderatePonds.toString(),
                            Icons.warning,
                            color: AppTheme.statusModerate,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Kolam Tidak Sehat',
                            unhealthyPonds.toString(),
                            Icons.error,
                            color: AppTheme.statusUnhealthy,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      'Statistik Ikan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Total Ikan',
                            totalFish.toString(),
                            Icons.set_meal,
                            color: AppTheme.accentBlue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Berat Rata-rata',
                            '${averageFishWeight.toStringAsFixed(1)}kg',
                            Icons.monitor_weight,
                            color: const Color(0xFF5DADE2),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      'Statistik Pakan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Stok Pakan',
                            '${totalFeedStock.toStringAsFixed(1)}kg',
                            Icons.restaurant,
                            color: AppTheme.accentOrange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Nilai Stok',
                            'Rp${totalFeedValue.toStringAsFixed(0)}',
                            Icons.attach_money,
                            color: const Color(0xFFF39C12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      'Statistik Kesehatan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Rekam Kesehatan',
                            totalHealthRecords.toString(),
                            Icons.health_and_safety,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Kesehatan Baik',
                            healthyRecords.toString(),
                            Icons.check_circle,
                            color: AppTheme.statusHealthy,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      'Statistik Produksi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Total Panen',
                            '${totalHarvestWeight.toStringAsFixed(1)}kg',
                            Icons.agriculture,
                            color: const Color(0xFFF1C40F),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Nilai Panen',
                            'Rp${totalHarvestValue.toStringAsFixed(0)}',
                            Icons.monetization_on,
                            color: const Color(0xFFF39C12),
                          ),
                        ),
                      ],
                    ),

                    // Alerts Section
                    if (alerts.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Peringatan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...alerts.map(
                        (alert) => Card(
                          color: Theme.of(context)
                              .colorScheme
                              .error
                              .withOpacity(0.1),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(
                              Icons.warning,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            title: Text(
                              alert,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    const Text(
                      'Grafik Produksi & Kesehatan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _generateHarvestSpots(harvests),
                              isCurved: true,
                              color: Theme.of(context).colorScheme.primary,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
                              ),
                              dotData: FlDotData(show: true),
                            ),
                            LineChartBarData(
                              spots: _generateHealthSpots(monitorings),
                              isCurved: true,
                              color: Theme.of(context).colorScheme.secondary,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.3),
                              ),
                              dotData: FlDotData(show: true),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  return LineTooltipItem(
                                    spot.y.toStringAsFixed(1),
                                    TextStyle(
                                      color: spot.bar.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem(
                            'Panen (kg)', Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 16),
                        _buildLegendItem(
                            'Kesehatan', Theme.of(context).colorScheme.secondary),
                      ],
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      'Aktivitas Terbaru',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActivityFeed(
                      ponds,
                      fish,
                      feeds,
                      monitorings,
                      feedings,
                      harvests,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon, {
    Color color = AppTheme.primaryGreen,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  List<FlSpot> _generateHarvestSpots(List harvests) {
    List<FlSpot> spots = [];
    for (int i = 0; i < harvests.length && i < 10; i++) {
      spots.add(FlSpot(i.toDouble(), harvests[i].weight));
    }
    if (spots.isEmpty) {
      spots.add(const FlSpot(0, 0));
    }
    return spots;
  }

  List<FlSpot> _generateHealthSpots(List monitorings) {
    List<FlSpot> spots = [];
    for (int i = 0; i < monitorings.length && i < 10; i++) {
      double healthValue = 0;
      if (monitorings[i].status == 'Normal') {
        healthValue = 3;
      } else if (monitorings[i].status == 'Baik') {
        healthValue = 2;
      } else if (monitorings[i].status == 'Buruk') {
        healthValue = 1;
      }
      spots.add(FlSpot(i.toDouble(), healthValue));
    }
    if (spots.isEmpty) {
      spots.add(const FlSpot(0, 0));
    }
    return spots;
  }

  Widget _buildActivityFeed(
    List ponds,
    List fish,
    List feeds,
    List monitorings,
    List feedings,
    List harvests,
  ) {
    List<Widget> activities = [];

    // Add recent activities
    if (ponds.isNotEmpty) {
      activities.add(
        _buildActivityCard(
          'Kolam "${ponds.last.name}" ditambahkan',
          'Baru saja',
          Icons.water_drop,
        ),
      );
    }
    if (fish.isNotEmpty) {
      activities.add(
        _buildActivityCard(
          '${fish.length} ikan tercatat dalam sistem',
          'Baru saja',
          Icons.set_meal,
        ),
      );
    }
    if (feeds.isNotEmpty) {
      activities.add(
        _buildActivityCard(
          'Stok pakan: ${feeds.fold(0.0, (sum, f) => sum + f.quantity).toStringAsFixed(1)}kg',
          'Baru saja',
          Icons.restaurant,
        ),
      );
    }
    if (monitorings.isNotEmpty) {
      activities.add(
        _buildActivityCard(
          '${monitorings.length} catatan kesehatan tercatat',
          'Baru saja',
          Icons.health_and_safety,
        ),
      );
    }
    if (feedings.isNotEmpty) {
      activities.add(
        _buildActivityCard(
          '${feedings.length} sesi pemberian pakan tercatat',
          'Baru saja',
          Icons.restaurant_menu,
        ),
      );
    }
    if (harvests.isNotEmpty) {
      activities.add(
        _buildActivityCard(
          'Total panen: ${harvests.fold(0.0, (sum, h) => sum + h.weight).toStringAsFixed(1)}kg',
          'Baru saja',
          Icons.agriculture,
        ),
      );
    }

    // If no activities, show default ones
    if (activities.isEmpty) {
      activities = [
        _buildActivityCard(
          'Sistem monitoring aktif',
          'Sekarang',
          Icons.monitor,
        ),
        _buildActivityCard('Database terhubung', 'Sekarang', Icons.cloud_done),
        _buildActivityCard(
          'Aplikasi siap digunakan',
          'Sekarang',
          Icons.check_circle,
        ),
      ];
    }

    return Column(
      children: activities.take(5).toList(), // Show only last 5 activities
    );
  }

  Widget _buildActivityCard(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
