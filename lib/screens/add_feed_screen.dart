import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feed_provider.dart';
import '../models/feed.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final feed = Feed(
        id: DateTime.now().toString(),
        name: _nameController.text,
        type: _typeController.text,
        quantity: double.parse(_quantityController.text),
        unit: _unitController.text,
        price: double.parse(_priceController.text),
        date: _dateController.text,
      );
      Provider.of<FeedProvider>(context, listen: false).addFeed(feed);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pakan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Pakan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Nama Pakan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tipe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Tipe';
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
                controller: _unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Unit';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Harga';
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
              ElevatedButton(onPressed: _save, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
