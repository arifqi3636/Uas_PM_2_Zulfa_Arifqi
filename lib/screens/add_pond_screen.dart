import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pond_provider.dart';
import '../models/pond.dart';

class AddPondScreen extends StatefulWidget {
  const AddPondScreen({super.key});

  @override
  State<AddPondScreen> createState() => _AddPondScreenState();
}

class _AddPondScreenState extends State<AddPondScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();
  String _status = 'healthy';

  @override
  void dispose() {
    _nameController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _depthController.dispose();
    super.dispose();
  }

  void _savePond() {
    if (_formKey.currentState!.validate()) {
      final pond = Pond(
        id: DateTime.now().toString(),
        name: _nameController.text,
        length: double.parse(_lengthController.text),
        width: double.parse(_widthController.text),
        depth: double.parse(_depthController.text),
        status: _status,
        imageUrl: 'assets/images/pond1.jpg', // Default image
      );
      Provider.of<PondProvider>(context, listen: false).addPond(pond);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kolam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Kolam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama kolam tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lengthController,
                decoration: const InputDecoration(labelText: 'Panjang (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Panjang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _widthController,
                decoration: const InputDecoration(labelText: 'Lebar (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lebar tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _depthController,
                decoration: const InputDecoration(labelText: 'Kedalaman (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kedalaman tidak boleh kosong';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'healthy', child: Text('Sehat')),
                  DropdownMenuItem(value: 'moderate', child: Text('Moderat')),
                  DropdownMenuItem(value: 'unhealthy', child: Text('Tidak Sehat')),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePond,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}