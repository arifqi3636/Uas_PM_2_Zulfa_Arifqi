import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fish_inventory_provider.dart';
import '../models/fish_inventory.dart';

class AddFishInventoryScreen extends StatefulWidget {
  const AddFishInventoryScreen({super.key});

  @override
  State<AddFishInventoryScreen> createState() => _AddFishInventoryScreenState();
}

class _AddFishInventoryScreenState extends State<AddFishInventoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pondIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _averageWeightController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _pondIdController.dispose();
    _quantityController.dispose();
    _averageWeightController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final inventory = FishInventory(
        id: DateTime.now().toString(),
        pondId: _pondIdController.text,
        quantity: int.parse(_quantityController.text),
        averageWeight: double.parse(_averageWeightController.text),
        date: _dateController.text,
      );
      Provider.of<FishInventoryProvider>(context, listen: false).addInventory(inventory);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Inventory Ikan'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _pondIdController,
                decoration: const InputDecoration(labelText: 'ID Kolam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan ID Kolam';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Jumlah';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _averageWeightController,
                decoration: const InputDecoration(labelText: 'Berat Rata-rata (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Berat Rata-rata';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Tanggal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Tanggal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}