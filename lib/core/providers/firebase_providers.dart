import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider =
Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// register others providers

final firebaseFirestoreProvider =
Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
//
// final firebaseStorageProvider =
// Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);