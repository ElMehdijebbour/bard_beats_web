import 'package:bardbeatsdash/core/providers/firebase_providers.dart';
import 'package:bardbeatsdash/firebase_options.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final Ref _ref; // use for reading other providers

  AuthDataSource(this._firebaseAuth, this._ref);

  Future<Either<String, User>> signup(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup.');
    }
  }

  Future<Either<String, User?>> login(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }

  Future<Either<String, User>> continueWithGoogle() async {
    try {
      final googleSignIn =
      GoogleSignIn(clientId: DefaultFirebaseOptions.ios.iosClientId);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        return right(response.user!);
      } else {
        return left('Unknown Error');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknow Error');
    }
  }
  Future<Either<String, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(null); // Success case, returning void
    } catch (e) {
      return left(e.toString()); // Error case
    }
  }

}

final authDataSourceProvider = Provider<AuthDataSource>(
      (ref) => AuthDataSource(ref.read(firebaseAuthProvider), ref),
);