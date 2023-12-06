// routes.dart
import 'package:bardbeatsdash/views/auth/sign_in/sign_in_page.dart';
import 'package:bardbeatsdash/views/auth/sign_up/sign_up_page.dart';
import 'package:bardbeatsdash/views/dashboard/dashboard_view.dart';
import 'package:bardbeatsdash/views/home/home_view.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String dashboard = '/dashboard';

  // Add more routes as constants here

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(),
      home: (context) => const HomePage(),
      signUp: (context) => const SignUpPage(),
      dashboard: (context) => const DashboardPage(),
      // Add more routes here
    };
  }
}
