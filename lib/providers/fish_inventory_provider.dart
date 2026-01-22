import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fish_inventory.dart';

class FishInventoryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<FishInventory> _inventories = [];
  bool _isLoading = false;

  List<FishInventory> get inventories => _inventories;
  bool get isLoading => _isLoading;

  Future<void> loadInventories() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('fish_inventories').get();
      _inventories = snapshot.docs.map((doc) => FishInventory.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addInventory(FishInventory inventory) async {
    try {
      final docRef = await _firestore.collection('fish_inventories').add(inventory.toMap());
      inventory.id = docRef.id;
      _inventories.add(inventory);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateInventory(FishInventory inventory) async {
    try {
      await _firestore.collection('fish_inventories').doc(inventory.id).update(inventory.toMap());
      final index = _inventories.indexWhere((i) => i.id == inventory.id);
      if (index != -1) {
        _inventories[index] = inventory;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteInventory(String id) async {
    try {
      await _firestore.collection('fish_inventories').doc(id).delete();
      _inventories.removeWhere((i) => i.id == id);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}