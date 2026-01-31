import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pond.dart';

class PondProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Pond> _ponds = [];
  bool _isLoading = false;

  List<Pond> get ponds => _ponds;
  bool get isLoading => _isLoading;

  Future<void> loadPonds() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('ponds').get();
      _ponds = snapshot.docs
          .map((doc) => Pond.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPond(Pond pond) async {
    try {
      final docRef = await _firestore.collection('ponds').add(pond.toMap());
      pond.id = docRef.id;
      _ponds.add(pond);
      notifyListeners();
    } catch (e) {
      // Rethrow so callers can react to failures (UI can show errors)
      rethrow;
    }
  }

  Future<void> updatePond(Pond pond) async {
    try {
      await _firestore.collection('ponds').doc(pond.id).update(pond.toMap());
      final index = _ponds.indexWhere((p) => p.id == pond.id);
      if (index != -1) {
        _ponds[index] = pond;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deletePond(String id) async {
    try {
      await _firestore.collection('ponds').doc(id).delete();
      _ponds.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
