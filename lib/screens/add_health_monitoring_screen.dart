import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';
import '../models/health_monitoring.dart';

class AddHealthMonitoringScreen extends StatefulWidget {
  const AddHealthMonitoringScreen({super.key});

  @override
  State<AddHealthMonitoringScreen> createState() =>
      _AddHealthMonitoringScreenState();
}

class _AddHealthMonitoringScreenState extends State<AddHealthMonitoringScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pondIdController = TextEditingController();
  final _parameterController = TextEditingController();
  final _valueController = TextEditingController();
  final _statusController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _pondIdController.dispose();
    _parameterController.dispose();
    _valueController.dispose();
    _statusController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final monitoring = HealthMonitoring(
        id: DateTime.now().toString(),
        pondId: _pondIdController.text,
        parameter: _parameterController.text,
        value: double.parse(_valueController.text),
        status: _statusController.text,
        date: _dateController.text,
        notes: _notesController.text,
      );
      Provider.of<HealthProvider>(
        context,
        listen: false,
      ).addMonitoring(monitoring);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Monitoring Kesehatan'),
        // backgroundColor: Colors.orange, // Removed inline color
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
                controller: _parameterController,
                decoration: const InputDecoration(labelText: 'Parameter'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Parameter';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Nilai'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Nilai';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Status';
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
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Catatan'),
                maxLines: 3,
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
