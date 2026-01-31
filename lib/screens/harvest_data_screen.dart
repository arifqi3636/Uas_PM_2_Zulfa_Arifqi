import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';
import '../providers/harvest_provider.dart';
import '../providers/pond_provider.dart';
import '../models/harvest.dart';
import '../models/pond.dart';

class HarvestDataScreen extends StatefulWidget {
  const HarvestDataScreen({super.key});

  @override
  State<HarvestDataScreen> createState() => _HarvestDataScreenState();
}

class _HarvestDataScreenState extends State<HarvestDataScreen> {
  String _filterPond = 'all';
  bool _showAnalytics = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HarvestProvider>(context, listen: false).loadHarvests();
      Provider.of<PondProvider>(context, listen: false).loadPonds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final harvestProvider = Provider.of<HarvestProvider>(context);
    final pondProvider = Provider.of<PondProvider>(context);
    final harvests = harvestProvider.harvests;
    final ponds = pondProvider.ponds;

    // Apply filtering
    var filteredHarvests = harvests.where((harvest) {
      return _filterPond == 'all' || harvest.pondId == _filterPond;
    }).toList();

    // Calculate harvest analytics
    double totalHarvest = filteredHarvests.fold(
      0.0,
      (sum, h) => sum + h.weight,
    );
    double totalValue = filteredHarvests.fold(
      0.0,
      (sum, h) => sum + (h.weight * h.pricePerKg),
    );
    int totalHarvests = filteredHarvests.length;
    double averageYield = totalHarvests > 0 ? totalHarvest / totalHarvests : 0;
    double averagePrice = totalHarvests > 0 ? totalValue / totalHarvest : 0;

    // Productivity analysis
    Map<String, double> pondProductivity = {};
    for (var harvest in filteredHarvests) {
      pondProductivity[harvest.pondId] =
          (pondProductivity[harvest.pondId] ?? 0) + harvest.weight;
    }

    // Forecasting (simple linear trend)
    double forecastYield = _calculateForecast(filteredHarvests);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Panen'),
        actions: [
          IconButton(
            icon: Icon(_showAnalytics ? Icons.list : Icons.analytics),
            onPressed: () => setState(() => _showAnalytics = !_showAnalytics),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ponds),
          ),
        ],
      ),
      body: harvestProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Summary cards
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                                'Total Panen',
                                '${totalHarvest.toStringAsFixed(1)}kg',
                                Icons.agriculture,
                              ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Nilai',
                              'Rp${totalValue.toStringAsFixed(0)}',
                              Icons.monetization_on,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Rata-rata Hasil',
                              '${averageYield.toStringAsFixed(1)}kg',
                              Icons.trending_up,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Harga Rata-rata',
                              'Rp${averagePrice.toStringAsFixed(0)}/kg',
                              Icons.attach_money,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Forecast Bulan Depan',
                              '${forecastYield.toStringAsFixed(1)}kg',
                              Icons.timeline,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Kolam Produktif',
                              pondProductivity.length.toString(),
                              Icons.water_drop,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: _showAnalytics
                      ? _buildAnalyticsView(pondProductivity, ponds)
                      : _buildHarvestList(filteredHarvests, ponds),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHarvestDialog(context, harvestProvider, ponds);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHarvestList(List<Harvest> filteredHarvests, List<Pond> ponds) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredHarvests.length,
      itemBuilder: (context, index) {
        final harvest = filteredHarvests[index];
        final pond = ponds.firstWhere(
          (p) => p.id == harvest.pondId,
          orElse: () => Pond(
            id: '',
            name: 'Unknown',
            length: 0,
            width: 0,
            depth: 0,
            status: '',
            imageUrl: '',
          ),
        );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.purple.shade100,
                child: const Icon(Icons.agriculture, color: Colors.purple),
              ),
              title: Text('Kolam: ${pond.name}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Berat: ${harvest.weight} ${harvest.unit}'),
                  Text('Harga per kg: Rp ${harvest.pricePerKg}'),
                  Text('Total Nilai: Rp ${harvest.totalValue}'),
                  Text(
                    'Tanggal: ${DateFormat('dd/MM/yyyy').format(harvest.date)}',
                  ),
                  if (harvest.notes.isNotEmpty)
                    Text('Catatan: ${harvest.notes}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Provider.of<HarvestProvider>(
                    context,
                    listen: false,
                  ).deleteHarvest(harvest.id);
                },
              ),
              onTap: () {
                // Edit functionality can be added here
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddHarvestDialog(
    BuildContext context,
    HarvestProvider harvestProvider,
    List<Pond> ponds,
  ) {
    final formKey = GlobalKey<FormState>();
    String selectedPondId = ponds.isNotEmpty ? ponds.first.id : '';
    double weight = 0;
    String unit = 'kg';
    double pricePerKg = 0;
    DateTime selectedDate = DateTime.now();
    String notes = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data Panen'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: selectedPondId,
                  items: ponds
                      .map(
                        (pond) => DropdownMenuItem(
                          value: pond.id,
                          child: Text(pond.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => selectedPondId = value!,
                  decoration: const InputDecoration(labelText: 'Kolam'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Berat'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Berat harus diisi' : null,
                  onSaved: (value) => weight = double.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Satuan'),
                  initialValue: unit,
                  onSaved: (value) => unit = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Harga per kg'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Harga harus diisi' : null,
                  onSaved: (value) => pricePerKg = double.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Catatan'),
                  onSaved: (value) => notes = value!,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                final harvest = Harvest(
                  id: '',
                  pondId: selectedPondId,
                  weight: weight,
                  unit: unit,
                  date: selectedDate,
                  pricePerKg: pricePerKg,
                  notes: notes,
                );
                harvestProvider.addHarvest(harvest);
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    [Color? color]
  ) {
    final col = color ?? AppTheme.primaryGreen;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [col.withOpacity(0.7), col],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsView(Map<String, double> pondProductivity, List ponds) {
    var sortedPonds = pondProductivity.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Icon(Icons.agriculture, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text(
              'Analisis Produktivitas Kolam',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...sortedPonds.map((entry) {
          final pond = ponds.firstWhere(
            (p) => p.id == entry.key,
            orElse: () => Pond(
              id: '',
              name: 'Unknown',
              length: 0,
              width: 0,
              depth: 0,
              status: '',
              imageUrl: '',
            ),
          );

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple.shade100,
                child: Text('${sortedPonds.indexOf(entry) + 1}'),
              ),
              title: Text(pond.name),
              subtitle: Text(
                'Total Panen: ${entry.value.toStringAsFixed(1)}kg',
              ),
              trailing: Icon(
                Icons.star,
                color: sortedPonds.indexOf(entry) < 3
                    ? Colors.amber
                    : Colors.grey,
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
        const Text(
          'Rekomendasi Perbaikan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.blue.shade50,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• Optimalkan pemberian pakan berdasarkan produktivitas kolam',
                ),
                Text('• Lakukan rotasi kolam untuk istirahat tanah'),
                Text('• Monitor kualitas air secara berkala'),
                Text('• Tingkatkan frekuensi panen untuk kolam produktif'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _calculateForecast(List harvests) {
    if (harvests.length < 2) return 0;

    // Simple linear regression for forecasting
    List<double> yields = harvests.map((h) => h.weight as double).toList();
    int n = yields.length;

    double sumX = 0;
    double sumY = 0;
    double sumXY = 0;
    double sumXX = 0;

    for (int i = 0; i < n; i++) {
      sumX += i;
      sumY += yields[i];
      sumXY += i * yields[i];
      sumXX += i * i;
    }

    double slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    double intercept = (sumY - slope * sumX) / n;

    // Forecast for next period
    return slope * n + intercept;
  }

  void _showFilterDialog(BuildContext context, List ponds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Data Panen'),
        content: DropdownButtonFormField<String>(
          initialValue: _filterPond,
          decoration: const InputDecoration(labelText: 'Kolam'),
          items: [
            const DropdownMenuItem(value: 'all', child: Text('Semua Kolam')),
            ...ponds.map(
              (pond) =>
                  DropdownMenuItem(value: pond.id, child: Text(pond.name)),
            ),
          ],
          onChanged: (value) => setState(() => _filterPond = value ?? 'all'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
