import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('user_uid');
    if (uid != null) {
      _user = _auth.currentUser;
      notifyListeners();
    }
  }

  Future<void> _saveUserToPrefs(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uid', uid);
  }

  Future<void> _clearUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uid');
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_user != null) {
        await _saveUserToPrefs(_user!.uid);
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await result.user!.updateDisplayName(name);
      if (_user != null) {
        await _saveUserToPrefs(_user!.uid);
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _clearUserFromPrefs();
  }
}