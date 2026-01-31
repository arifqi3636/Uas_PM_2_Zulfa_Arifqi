import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/harvest_provider.dart';
import '../providers/feeding_provider.dart';
import '../providers/pond_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HarvestProvider>(context, listen: false).loadHarvests();
      Provider.of<FeedingProvider>(context, listen: false).loadFeedings();
      Provider.of<PondProvider>(context, listen: false).loadPonds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final harvestProvider = Provider.of<HarvestProvider>(context);
    final feedingProvider = Provider.of<FeedingProvider>(context);
    final pondProvider = Provider.of<PondProvider>(context);

    final harvests = harvestProvider.harvests;
    final feedings = feedingProvider.feedings;
    final ponds = pondProvider.ponds;

    // Calculate real-time statistics
    double totalHarvestWeight = harvests.fold(0.0, (sum, h) => sum + h.weight);
    double totalHarvestValue =
        harvests.fold(0.0, (sum, h) => sum + (h.weight * h.pricePerKg));
    double totalFeedingQuantity =
        feedings.fold(0.0, (sum, f) => sum + f.quantity);
    int totalPonds = ponds.length;
    int activePonds = ponds.where((p) => p.status == 'healthy').length;

    // Generate bar chart data from harvests
    List<BarChartGroupData> barGroups = [];
    Map<int, double> monthlyHarvest = {};
    for (var harvest in harvests) {
      int month = harvest.date.month;
      monthlyHarvest[month] = (monthlyHarvest[month] ?? 0) + harvest.weight;
    }
    for (int i = 1; i <= 12; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i - 1,
          barRods: [
            BarChartRodData(
                toY: monthlyHarvest[i] ?? 0,
                color: Theme.of(context).colorScheme.primary),
          ],
        ),
      );
    }
    if (barGroups.isEmpty) {
      barGroups = List.generate(
        3,
        (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(toY: 0, color: Theme.of(context).colorScheme.primary)
            ],
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
      ),
      body: harvestProvider.isLoading ||
              feedingProvider.isLoading ||
              pondProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Laporan Produksi Real-time',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Panen',
                          '${totalHarvestWeight.toStringAsFixed(1)} kg',
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Total Nilai',
                          'Rp${totalHarvestValue.toStringAsFixed(0)}',
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Pakan Diberikan',
                          '${totalFeedingQuantity.toStringAsFixed(1)} kg',
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Kolam Aktif',
                          '$activePonds / $totalPonds',
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Grafik Produksi Bulanan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: barGroups,
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const months = [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun',
                                  'Jul',
                                  'Aug',
                                  'Sep',
                                  'Oct',
                                  'Nov',
                                  'Dec'
                                ];
                                if (value.toInt() >= 0 && value.toInt() < months.length) {
                                  return Text(months[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Data Panen Terbaru',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildHarvestTable(harvests),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<HarvestProvider>(context, listen: false)
                            .loadHarvests();
                        Provider.of<FeedingProvider>(context, listen: false)
                            .loadFeedings();
                        Provider.of<PondProvider>(context, listen: false)
                            .loadPonds();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data sudah diperbarui')),
                        );
                      },
                      child: const Text('Segarkan Data'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHarvestTable(List harvests) {
    if (harvests.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('Belum ada data panen'),
        ),
      );
    }
    final recent = harvests.take(5).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Tanggal')),
          DataColumn(label: Text('Kolam')),
          DataColumn(label: Text('Berat (kg)')),
          DataColumn(label: Text('Harga/kg (Rp)')),
        ],
        rows: recent
            .map((h) => DataRow(
                  cells: [
                    DataCell(Text(DateFormat('yyyy-MM-dd').format(h.date))),
                    DataCell(Text(h.pondId)),
                    DataCell(Text(h.weight.toStringAsFixed(1))),
                    DataCell(Text(h.pricePerKg.toStringAsFixed(0))),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
