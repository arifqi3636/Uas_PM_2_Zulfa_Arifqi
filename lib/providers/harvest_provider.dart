import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/harvest.dart';

class HarvestProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Harvest> _harvests = [];
  bool _isLoading = false;

  List<Harvest> get harvests => _harvests;
  bool get isLoading => _isLoading;

  Future<void> loadHarvests() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('harvests').get();
      _harvests = snapshot.docs.map((doc) => Harvest.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHarvest(Harvest harvest) async {
    try {
      final docRef = await _firestore.collection('harvests').add(harvest.toMap());
      harvest.id = docRef.id;
      _harvests.add(harvest);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateHarvest(Harvest harvest) async {
    try {
      await _firestore.collection('harvests').doc(harvest.id).update(harvest.toMap());
      final index = _harvests.indexWhere((h) => h.id == harvest.id);
      if (index != -1) {
        _harvests[index] = harvest;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteHarvest(String id) async {
    try {
      await _firestore.collection('harvests').doc(id).delete();
      _harvests.removeWhere((h) => h.id == id);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}