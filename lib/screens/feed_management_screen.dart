import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/feed_provider.dart';
import '../models/feed.dart';

class FeedManagementScreen extends StatefulWidget {
  const FeedManagementScreen({super.key});

  @override
  State<FeedManagementScreen> createState() => _FeedManagementScreenState();
}

class _FeedManagementScreenState extends State<FeedManagementScreen> {
  String _sortBy = 'date'; // 'date', 'quantity', 'price'
  bool _sortAscending = false;
  String _filterType = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedProvider>(context, listen: false).loadFeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedProvider>(context);
    final feeds = provider.feeds;

    // Apply filtering
    var filteredFeeds = feeds.where((feed) {
      return _filterType == 'all' || feed.type == _filterType;
    }).toList();

    // Apply sorting
    filteredFeeds.sort((a, b) {
      int comparison = 0;
      switch (_sortBy) {
        case 'date':
          comparison = a.date.compareTo(b.date);
          break;
        case 'quantity':
          comparison = a.quantity.compareTo(b.quantity);
          break;
        case 'price':
          comparison = a.price.compareTo(b.price);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });

    // Calculate statistics
    double totalStock = filteredFeeds.fold(
      0.0,
      (sum, feed) => sum + feed.quantity,
    );
    double totalValue = filteredFeeds.fold(
      0.0,
      (sum, feed) => sum + (feed.quantity * feed.price),
    );
    int uniqueTypes = filteredFeeds.map((f) => f.type).toSet().length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Pakan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, feeds),
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
                // Summary cards
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Stok',
                              '${totalStock.toStringAsFixed(1)}kg',
                              Icons.inventory,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Nilai',
                              'Rp${totalValue.toStringAsFixed(0)}',
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
                              'Jenis Pakan',
                              uniqueTypes.toString(),
                              Icons.category,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              'Rata-rata Harga',
                              'Rp${(filteredFeeds.isEmpty ? 0 : totalValue / totalStock).toStringAsFixed(0)}/kg',
                              Icons.trending_up,
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
                    itemCount: filteredFeeds.length,
                    itemBuilder: (context, index) {
                      final feed = filteredFeeds[index];
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
                                  Theme.of(context).colorScheme.primary.withOpacity(0.12),
                              child: Icon(
                                Icons.restaurant,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(feed.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tipe: ${feed.type}'),
                                Text('Jumlah: ${feed.quantity} ${feed.unit}'),
                                Text('Harga: Rp ${feed.price}'),
                                Text('Tanggal: ${feed.date}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Theme.of(context).colorScheme.error),
                              onPressed: () {
                                provider.deleteFeed(feed.id);
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
          _showAddFeedDialog(context, provider);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddFeedDialog(BuildContext context, FeedProvider feedProvider) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final typeController = TextEditingController();
    final quantityController = TextEditingController();
    final unitController = TextEditingController();
    final priceController = TextEditingController();
    final dateController = TextEditingController(
      text: DateTime.now().toString().split(' ')[0],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pakan'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Pakan'),
                  validator: (value) =>
                      value!.isEmpty ? 'Nama pakan harus diisi' : null,
                ),
                TextFormField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Tipe'),
                  validator: (value) =>
                      value!.isEmpty ? 'Tipe harus diisi' : null,
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Jumlah'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah harus diisi';
                    }
                    final normalized = value.replaceAll(',', '.').trim();
                    try {
                      double.parse(normalized);
                      return null;
                    } catch (e) {
                      return 'Jumlah harus berupa angka';
                    }
                  },
                ),
                TextFormField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Satuan'),
                  validator: (value) =>
                      value!.isEmpty ? 'Satuan harus diisi' : null,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga harus diisi';
                    }
                    final normalized = value.replaceAll(',', '.').trim();
                    try {
                      double.parse(normalized);
                      return null;
                    } catch (e) {
                      return 'Harga harus berupa angka';
                    }
                  },
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                  validator: (value) =>
                      value!.isEmpty ? 'Tanggal harus diisi' : null,
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
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              double quantity;
              double price;
              try {
                quantity = double.parse(
                  quantityController.text.replaceAll(',', '.').trim(),
                );
                price = double.parse(
                  priceController.text.replaceAll(',', '.').trim(),
                );
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Jumlah dan Harga harus berupa angka'),
                  ),
                );
                return;
              }

              try {
                final feed = Feed(
                  id: '',
                  name: nameController.text,
                  type: typeController.text,
                  quantity: quantity,
                  unit: unitController.text,
                  price: price,
                  date: dateController.text,
                );
                await feedProvider.addFeed(feed);
                if (!context.mounted) return;
                Navigator.pop(context);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal menyimpan pakan: $e')),
                );
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
                fontSize: 16,
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

  void _showFilterDialog(BuildContext context, List feeds) {
    Set<String> feedTypes = feeds.map((f) => f.type as String).toSet();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Pakan'),
        content: DropdownButtonFormField<String>(
          initialValue: _filterType,
          decoration: const InputDecoration(labelText: 'Tipe Pakan'),
          items: [
            const DropdownMenuItem(value: 'all', child: Text('Semua Tipe')),
            ...feedTypes.map(
              (type) => DropdownMenuItem(value: type, child: Text(type)),
            ),
          ],
          onChanged: (value) => setState(() => _filterType = value ?? 'all'),
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
              title: const Text('Jumlah'),
              value: 'quantity',
              groupValue: _sortBy,
              onChanged: (value) => setState(() => _sortBy = value!),
            ),
            RadioListTile<String>(
              title: const Text('Harga'),
              value: 'price',
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
