import 'package:bardbeatsdash/features/auth/data_source/auth_data_source.dart';
import 'package:bardbeatsdash/features/auth/providers/state/authentication_state.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this._dataSource) : super(const AuthenticationState.initial());

  final AuthDataSource _dataSource;
  // Add a method or property to check if the user is authenticated
  bool get isAuthenticated {
    return state.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );
  }
  String get userId {
    return state.maybeWhen(
      authenticated: (_) => _.uid,
      orElse: () => '',
    );
  }
  Future<void> login({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.login(email: email, password: password);
    state = response.fold(
          (error) => AuthenticationState.unauthenticated(message: error),
          (response) => AuthenticationState.authenticated(user: response!),
    );
  }

  Future<void> signup({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.signup(email: email, password: password);
    state = response.fold(
          (error) => AuthenticationState.unauthenticated(message: error),
          (response) => AuthenticationState.authenticated(user: response),
    );
  }

  Future<void> continueWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.continueWithGoogle();
    state = response.fold(
          (error) => AuthenticationState.unauthenticated(message: error),
          (response) => AuthenticationState.authenticated(user: response),
    );
  }

  Future<void> signOut() async {
    state = const AuthenticationState.loading();

    // Assuming _dataSource.signOut() returns a response similar to signup and continueWithGoogle
    final response = await _dataSource.signOut().catchError((error) {
      // Handle any errors during the signOut process
      return Left(error.toString()); // Left is typically used for failure
    });

    state = response.fold(
          (error) => AuthenticationState.unauthenticated(message: error),
          (_) => const AuthenticationState.unauthenticated(), // Sign out doesn't need a response
    );
  }



}

final authNotifierProvider =
StateNotifierProvider<AuthNotifier, AuthenticationState>(
      (ref) => AuthNotifier(ref.read(authDataSourceProvider)),
);