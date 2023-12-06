import 'package:bardbeatsdash/core/middlewares/middleware.dart';
import 'package:bardbeatsdash/router/router.dart';
import 'package:bardbeatsdash/themes/app_themes.dart';
import 'package:bardbeatsdash/views/auth/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GoRouter _router = AppRouter.createRouter();
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {

          return MaterialApp.router(
            key: navigatorKey,
            routerConfig: _router,
            title: 'Flutter Demo',
            theme: AppTheme.darkTheme,
          );
        }
    );
  }
}

