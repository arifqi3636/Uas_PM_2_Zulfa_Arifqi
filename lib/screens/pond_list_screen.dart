import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/pond_provider.dart';
import '../models/pond.dart';

class PondListScreen extends StatefulWidget {
  const PondListScreen({super.key});

  @override
  State<PondListScreen> createState() => _PondListScreenState();
}

class _PondListScreenState extends State<PondListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PondProvider>(context, listen: false).loadPonds();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'healthy':
        return AppTheme.statusHealthy;
      case 'moderate':
        return AppTheme.statusModerate;
      case 'unhealthy':
        return AppTheme.statusUnhealthy;
      default:
        return AppTheme.textLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pondProvider = Provider.of<PondProvider>(context);
    final ponds = pondProvider.ponds;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kolam'),
      ),
      body: pondProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ponds.length,
              itemBuilder: (context, index) {
                final pond = ponds[index];
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
                        child: Icon(Icons.water_drop, color: Theme.of(context).colorScheme.primary),
                      ),
                      title: Text(pond.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Volume: ${pond.volume.toStringAsFixed(2)} m³'),
                          Text(
                            'Ukuran: ${pond.length.toStringAsFixed(1)}m x ${pond.width.toStringAsFixed(1)}m x ${pond.depth.toStringAsFixed(1)}m',
                          ),
                          Text('Status: ${pond.status}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getStatusColor(pond.status),
                              shape: BoxShape.circle,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                            onPressed: () {
                              pondProvider.deletePond(pond.id);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _showEditPondDialog(context, pondProvider, pond);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPondDialog(context, pondProvider);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPondDialog(BuildContext context, PondProvider pondProvider) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final lengthController = TextEditingController();
    final widthController = TextEditingController();
    final depthController = TextEditingController();
    final statusController = TextEditingController();
    final imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Kolam'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Kolam'),
                  validator: (value) =>
                      value!.isEmpty ? 'Nama kolam harus diisi' : null,
                ),
                TextFormField(
                  controller: lengthController,
                  decoration: const InputDecoration(labelText: 'Panjang (m)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Panjang harus diisi' : null,
                ),
                TextFormField(
                  controller: widthController,
                  decoration: const InputDecoration(labelText: 'Lebar (m)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Lebar harus diisi' : null,
                ),
                TextFormField(
                  controller: depthController,
                  decoration: const InputDecoration(labelText: 'Kedalaman (m)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Kedalaman harus diisi' : null,
                ),
                TextFormField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: 'Status'),
                  validator: (value) =>
                      value!.isEmpty ? 'Status harus diisi' : null,
                ),
                TextFormField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'URL Gambar'),
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
              if (!formKey.currentState!.validate()) return;
              try {
                double parse(String v) {
                  final normalized = v.replaceAll(',', '.').trim();
                  return double.parse(normalized);
                }

                final pond = Pond(
                  id: '',
                  name: nameController.text,
                  length: parse(lengthController.text),
                  width: parse(widthController.text),
                  depth: parse(depthController.text),
                  status: statusController.text,
                  imageUrl: imageUrlController.text,
                );
                pondProvider.addPond(pond);
                Navigator.pop(context);
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nilai panjang/ lebar/ kedalaman tidak valid')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showEditPondDialog(
    BuildContext context,
    PondProvider pondProvider,
    Pond pond,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Kolam'),
        content: const Text('Edit functionality coming soon'),
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
