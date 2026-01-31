import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feeding.dart';

class FeedingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Feeding> _feedings = [];
  bool _isLoading = false;

  List<Feeding> get feedings => _feedings;
  bool get isLoading => _isLoading;

  Future<void> loadFeedings() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('feedings').get();
      _feedings = snapshot.docs
          .map((doc) => Feeding.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFeeding(Feeding feeding) async {
    try {
      final docRef = await _firestore
          .collection('feedings')
          .add(feeding.toMap());
      feeding.id = docRef.id;
      _feedings.add(feeding);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateFeeding(Feeding feeding) async {
    try {
      await _firestore
          .collection('feedings')
          .doc(feeding.id)
          .update(feeding.toMap());
      final index = _feedings.indexWhere((f) => f.id == feeding.id);
      if (index != -1) {
        _feedings[index] = feeding;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteFeeding(String id) async {
    try {
      await _firestore.collection('feedings').doc(id).delete();
      _feedings.removeWhere((f) => f.id == id);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
