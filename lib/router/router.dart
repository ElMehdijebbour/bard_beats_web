// router.dart
import 'package:bardbeatsdash/features/auth/data_source/auth_data_source.dart';
import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/features/auth/providers/state/authentication_state.dart';
import 'package:bardbeatsdash/views/auth/sign_in/sign_in_page.dart';
import 'package:bardbeatsdash/views/auth/sign_up/sign_up_page.dart';
import 'package:bardbeatsdash/views/dashboard/dashboard_view.dart';
import 'package:bardbeatsdash/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../core/middlewares/middleware.dart';
import 'routes.dart';

class AppRouter {
  static GoRouter createRouter() {

    return GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
      ],
      redirect: (context, state) {
        // Access the provider using the context
        final container = ProviderScope.containerOf(context, listen: false);
        final auth = container.read(loginInfoProvider);

        // Redirect logic
        final loggedIn = auth.isAuthenticated;
        final isLoggingIn = state.fullPath == '/login';
        final isSigningUp = state.fullPath == '/signup';

        if (loggedIn) {
          // Redirect logged in users away from login/signup to home
          if (isLoggingIn || isSigningUp) {
            return '/';
          }
        } else {
          // Redirect not logged in users away from home to login, but allow signup
          if (!isLoggingIn && !isSigningUp && state.path != '/') {
            return '/login';
          }
        }
        // No redirection necessary
        return null;
      },


    );
  }
}
