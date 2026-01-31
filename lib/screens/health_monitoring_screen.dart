import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/health_provider.dart';
import '../models/health_monitoring.dart';

class HealthMonitoringScreen extends StatefulWidget {
  const HealthMonitoringScreen({super.key});

  @override
  State<HealthMonitoringScreen> createState() => _HealthMonitoringScreenState();
}

class _HealthMonitoringScreenState extends State<HealthMonitoringScreen> {
  String _sortBy = 'date'; // 'date', 'parameter', 'value'
  bool _sortAscending = false;
  String _filterStatus = 'all'; // 'Normal', 'Baik', 'Buruk'
  String _filterParameter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HealthProvider>(context, listen: false).loadMonitorings();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Normal':
        return AppTheme.statusHealthy;
      case 'Baik':
        return AppTheme.statusModerate;
      case 'Buruk':
        return AppTheme.statusUnhealthy;
      default:
        return AppTheme.textLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    final monitorings = provider.monitorings;

    // Apply filtering
    var filteredMonitorings = monitorings.where((monitoring) {
      bool statusMatch =
          _filterStatus == 'all' || monitoring.status == _filterStatus;
      bool parameterMatch =
          _filterParameter == 'all' || monitoring.parameter == _filterParameter;
      return statusMatch && parameterMatch;
    }).toList();

    // Apply sorting
    filteredMonitorings.sort((a, b) {
      int comparison = 0;
      switch (_sortBy) {
        case 'date':
          comparison = a.date.compareTo(b.date);
          break;
        case 'parameter':
          comparison = a.parameter.compareTo(b.parameter);
          break;
        case 'value':
          comparison = a.value.compareTo(b.value);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });

    // Calculate health statistics
    int totalRecords = filteredMonitorings.length;
    int healthyRecords = filteredMonitorings
        .where((m) => m.status == 'Normal')
        .length;
    int goodRecords = filteredMonitorings
        .where((m) => m.status == 'Baik')
        .length;
    int poorRecords = filteredMonitorings
        .where((m) => m.status == 'Buruk')
        .length;

    // Generate alerts
    List<String> alerts = [];
    if (poorRecords > 0) {
      alerts.add('$poorRecords catatan kesehatan menunjukkan kondisi buruk');
    }
    if (healthyRecords < totalRecords * 0.5 && totalRecords > 0) {
      alerts.add('Kurang dari 50% kondisi kesehatan optimal');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Kesehatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, monitorings),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Health alerts
                if (alerts.isNotEmpty)
                  Container(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.warning,
                            color: Theme.of(context).colorScheme.error),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            alerts.join('. '),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Summary cards
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                                'Total Rekam',
                                totalRecords.toString(),
                                Icons.health_and_safety,
                              ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Kesehatan Normal',
                              healthyRecords.toString(),
                              Icons.check_circle,
                              AppTheme.statusHealthy,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Kesehatan Baik',
                              goodRecords.toString(),
                              Icons.thumb_up,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Perlu Perhatian',
                              poorRecords.toString(),
                              Icons.warning,
                              AppTheme.statusUnhealthy,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredMonitorings.length,
                    itemBuilder: (context, index) {
                      final monitoring = filteredMonitorings[index];
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
                              backgroundColor:
                                  _getStatusColor(monitoring.status).withOpacity(0.12),
                              child: Icon(
                                Icons.health_and_safety,
                                color: _getStatusColor(monitoring.status),
                              ),
                            ),
                            title: Text(
                              '${monitoring.parameter}: ${monitoring.value}',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kolam: ${monitoring.pondId}'),
                                Text('Status: ${monitoring.status}'),
                                Text('Tanggal: ${monitoring.date}'),
                                Text('Catatan: ${monitoring.notes}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Theme.of(context).colorScheme.error),
                              onPressed: () {
                                provider.deleteMonitoring(monitoring.id);
                              },
                            ),
                            onTap: () {
                              // Edit functionality can be added here
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHealthDialog(context, provider);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddHealthDialog(
    BuildContext context,
    HealthProvider healthProvider,
  ) {
    final formKey = GlobalKey<FormState>();
    final parameterController = TextEditingController();
    final valueController = TextEditingController();
    final pondIdController = TextEditingController();
    final statusController = TextEditingController();
    final dateController = TextEditingController(
      text: DateTime.now().toString().split(' ')[0],
    );
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Monitoring Kesehatan'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: parameterController,
                  decoration: const InputDecoration(labelText: 'Parameter'),
                  validator: (value) =>
                      value!.isEmpty ? 'Parameter harus diisi' : null,
                ),
                TextFormField(
                  controller: valueController,
                  decoration: const InputDecoration(labelText: 'Nilai'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Nilai harus diisi' : null,
                ),
                TextFormField(
                  controller: pondIdController,
                  decoration: const InputDecoration(labelText: 'ID Kolam'),
                  validator: (value) =>
                      value!.isEmpty ? 'ID Kolam harus diisi' : null,
                ),
                TextFormField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: 'Status'),
                  validator: (value) =>
                      value!.isEmpty ? 'Status harus diisi' : null,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                  validator: (value) =>
                      value!.isEmpty ? 'Tanggal harus diisi' : null,
                ),
                TextFormField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Catatan'),
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
                final monitoring = HealthMonitoring(
                  id: '',
                  parameter: parameterController.text,
                  value: double.parse(valueController.text),
                  pondId: pondIdController.text,
                  status: statusController.text,
                  date: dateController.text,
                  notes: notesController.text,
                );
                healthProvider.addMonitoring(monitoring);
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context, List monitorings) {
    Set<String> statuses = monitorings.map((m) => m.status as String).toSet();
    Set<String> parameters = monitorings
        .map((m) => m.parameter as String)
        .toSet();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Kesehatan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _filterStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: [
                const DropdownMenuItem(
                  value: 'all',
                  child: Text('Semua Status'),
                ),
                ...statuses.map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status)),
                ),
              ],
              onChanged: (value) =>
                  setState(() => _filterStatus = value ?? 'all'),
            ),
            DropdownButtonFormField<String>(
              initialValue: _filterParameter,
              decoration: const InputDecoration(labelText: 'Parameter'),
              items: [
                const DropdownMenuItem(
                  value: 'all',
                  child: Text('Semua Parameter'),
                ),
                ...parameters.map(
                  (param) => DropdownMenuItem(value: param, child: Text(param)),
                ),
              ],
              onChanged: (value) =>
                  setState(() => _filterParameter = value ?? 'all'),
            ),
          ],
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

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Urutkan Berdasarkan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Tanggal'),
              value: 'date',
              groupValue: _sortBy,
              onChanged: (value) => setState(() => _sortBy = value!),
            ),
            RadioListTile<String>(
              title: const Text('Parameter'),
              value: 'parameter',
              groupValue: _sortBy,
              onChanged: (value) => setState(() => _sortBy = value!),
            ),
            RadioListTile<String>(
              title: const Text('Nilai'),
              value: 'value',
              groupValue: _sortBy,
              onChanged: (value) => setState(() => _sortBy = value!),
            ),
            const Divider(),
            CheckboxListTile(
              title: const Text('Urutkan Naik'),
              value: _sortAscending,
              onChanged: (value) =>
                  setState(() => _sortAscending = value ?? false),
            ),
          ],
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
