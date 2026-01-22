import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/health_monitoring.dart';

class HealthProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<HealthMonitoring> _monitorings = [];
  bool _isLoading = false;

  List<HealthMonitoring> get monitorings => _monitorings;
  bool get isLoading => _isLoading;

  Future<void> loadMonitorings() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('health_monitorings').get();
      _monitorings = snapshot.docs.map((doc) => HealthMonitoring.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMonitoring(HealthMonitoring monitoring) async {
    try {
      final docRef = await _firestore.collection('health_monitorings').add(monitoring.toMap());
      monitoring.id = docRef.id;
      _monitorings.add(monitoring);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateMonitoring(HealthMonitoring monitoring) async {
    try {
      await _firestore.collection('health_monitorings').doc(monitoring.id).update(monitoring.toMap());
      final index = _monitorings.indexWhere((m) => m.id == monitoring.id);
      if (index != -1) {
        _monitorings[index] = monitoring;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteMonitoring(String id) async {
    try {
      await _firestore.collection('health_monitorings').doc(id).delete();
      _monitorings.removeWhere((m) => m.id == id);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}