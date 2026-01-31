import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feed.dart';

class FeedProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Feed> _feeds = [];
  bool _isLoading = false;

  List<Feed> get feeds => _feeds;
  bool get isLoading => _isLoading;

  Future<void> loadFeeds() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('feeds').get();
      _feeds = snapshot.docs
          .map((doc) => Feed.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFeed(Feed feed) async {
    try {
      final docRef = await _firestore.collection('feeds').add(feed.toMap());
      feed.id = docRef.id;
      _feeds.add(feed);
      notifyListeners();
    } catch (e) {
      // Rethrow so callers can react to failures
      rethrow;
    }
  }

  Future<void> updateFeed(Feed feed) async {
    try {
      await _firestore.collection('feeds').doc(feed.id).update(feed.toMap());
      final index = _feeds.indexWhere((f) => f.id == feed.id);
      if (index != -1) {
        _feeds[index] = feed;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteFeed(String id) async {
    try {
      await _firestore.collection('feeds').doc(id).delete();
      _feeds.removeWhere((f) => f.id == id);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
