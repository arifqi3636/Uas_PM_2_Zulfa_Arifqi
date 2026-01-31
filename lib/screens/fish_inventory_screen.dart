import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/fish_inventory_provider.dart';
import '../providers/pond_provider.dart';
import '../models/fish_inventory.dart';
import '../models/pond.dart';

class FishInventoryScreen extends StatefulWidget {
  const FishInventoryScreen({super.key});

  @override
  State<FishInventoryScreen> createState() => _FishInventoryScreenState();
}

class _FishInventoryScreenState extends State<FishInventoryScreen> {
  String _sortBy = 'date'; // 'date', 'weight', 'quantity'
  bool _sortAscending = false;
  String _filterPond = 'all';
  String _filterStatus = 'all'; // 'healthy', 'moderate', 'unhealthy'

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FishInventoryProvider>(
        context,
        listen: false,
      ).loadInventories();
      Provider.of<PondProvider>(context, listen: false).loadPonds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<FishInventoryProvider>(context);
    final pondProvider = Provider.of<PondProvider>(context);
    final inventories = inventoryProvider.inventories;
    final ponds = pondProvider.ponds;

    // Apply filtering
    var filteredInventories = inventories.where((inventory) {
      final pond = ponds.firstWhere(
        (p) => p.id == inventory.pondId,
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
      bool pondMatch = _filterPond == 'all' || pond.id == _filterPond;
      bool statusMatch = _filterStatus == 'all' || pond.status == _filterStatus;
      return pondMatch && statusMatch;
    }).toList();

    // Apply sorting
    filteredInventories.sort((a, b) {
      int comparison = 0;
      switch (_sortBy) {
        case 'date':
          comparison = a.date.compareTo(b.date);
          break;
        case 'weight':
          comparison = a.averageWeight.compareTo(b.averageWeight);
          break;
        case 'quantity':
          comparison = a.quantity.compareTo(b.quantity);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Ikan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ponds),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context),
          ),
        ],
      ),
      body: inventoryProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Summary cards
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          'Total Ikan',
                          filteredInventories
                              .fold(0, (sum, inv) => sum + inv.quantity)
                              .toString(),
                          Icons.set_meal,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSummaryCard(
                          'Berat Rata-rata',
                          '${(filteredInventories.isEmpty ? 0 : filteredInventories.fold(0.0, (sum, inv) => sum + inv.averageWeight) / filteredInventories.length).toStringAsFixed(1)}kg',
                          Icons.monitor_weight,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredInventories.length,
                    itemBuilder: (context, index) {
                      final inventory = filteredInventories[index];
                      final pond = ponds.firstWhere(
                        (p) => p.id == inventory.pondId,
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
                              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                              child: Icon(
                                Icons.inventory,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text('Kolam: ${pond.name}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Jumlah: ${inventory.quantity} ekor'),
                                Text(
                                  'Berat Rata-rata: ${inventory.averageWeight} kg',
                                ),
                                Text('Tanggal: ${inventory.date}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                              onPressed: () {
                                inventoryProvider.deleteInventory(inventory.id);
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
          _showAddInventoryDialog(context, inventoryProvider, ponds);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddInventoryDialog(
    BuildContext context,
    FishInventoryProvider inventoryProvider,
    List<Pond> ponds,
  ) {
    final formKey = GlobalKey<FormState>();
    String selectedPondId = ponds.isNotEmpty ? ponds.first.id : '';
    int quantity = 0;
    double averageWeight = 0;
    String date = DateTime.now().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Inventory Ikan'),
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
                  decoration: const InputDecoration(labelText: 'Jumlah (ekor)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Jumlah harus diisi' : null,
                  onSaved: (value) => quantity = int.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Berat Rata-rata (kg)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Berat rata-rata harus diisi' : null,
                  onSaved: (value) => averageWeight = double.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                  initialValue: date,
                  onSaved: (value) => date = value!,
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
                final inventory = FishInventory(
                  id: '',
                  pondId: selectedPondId,
                  quantity: quantity,
                  averageWeight: averageWeight,
                  date: date,
                );
                inventoryProvider.addInventory(inventory);
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppTheme.primaryGreen, AppTheme.primaryGreenLight],
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
            Text(title, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context, List<Pond> ponds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Inventory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _filterPond,
              decoration: const InputDecoration(labelText: 'Kolam'),
              items: [
                const DropdownMenuItem(
                  value: 'all',
                  child: Text('Semua Kolam'),
                ),
                ...ponds.map(
                  (pond) =>
                      DropdownMenuItem(value: pond.id, child: Text(pond.name)),
                ),
              ],
              onChanged: (value) =>
                  setState(() => _filterPond = value ?? 'all'),
            ),
            DropdownButtonFormField<String>(
              initialValue: _filterStatus,
              decoration: const InputDecoration(labelText: 'Status Kolam'),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('Semua Status')),
                DropdownMenuItem(value: 'healthy', child: Text('Sehat')),
                DropdownMenuItem(value: 'moderate', child: Text('Moderat')),
                DropdownMenuItem(
                  value: 'unhealthy',
                  child: Text('Tidak Sehat'),
                ),
              ],
              onChanged: (value) =>
                  setState(() => _filterStatus = value ?? 'all'),
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
              title: const Text('Berat Rata-rata'),
              value: 'weight',
              groupValue: _sortBy,
              onChanged: (value) => setState(() => _sortBy = value!),
            ),
            RadioListTile<String>(
              title: const Text('Jumlah'),
              value: 'quantity',
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
