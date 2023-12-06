import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/routes.dart';

class Auth extends ChangeNotifier {
  late FirebaseAuth _firebaseAuth;
  User? _user;

  bool get isAuthenticated => _user != null;

  Auth() {
    _firebaseAuth = FirebaseAuth.instance;
    // Initialize the listener in the constructor
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}



final loginInfoProvider = ChangeNotifierProvider<Auth>((ref) {
  return Auth();
});
