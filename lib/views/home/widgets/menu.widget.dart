import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/features/menu/providers/menu_provider.dart';
import 'package:bardbeatsdash/generated/assets.dart';
import 'package:bardbeatsdash/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MenuWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int _selectedIconIndex = ref.watch(selectedIconIndexProvider.notifier).state;
    // Listener for authentication state
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {},
        unauthenticated: (message) {
          return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message!),
                behavior: SnackBarBehavior.floating,
              ),
            );

        },
      );
    });
    return Column(
      children: <Widget>[
        // Logo
        SvgPicture.asset(
          Assets.logoLogo, // Replace with your logo asset path
          width: 70,
          height: 70,
        ),

        const SizedBox(height: 30),

        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10), // Add margin for spacing around the menu
              padding: const EdgeInsets.all(10), // Add padding inside the menu
              decoration: BoxDecoration(
                color: const Color(0xff1A1E1F), // Adjust the background color and opacity
                borderRadius: BorderRadius.circular(30), // Circular borders for the entire menu
              ),
              child: Column(
                children: [
                  // First Menu
                  _menuIcon(ref,FontAwesomeIcons.igloo, 0),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _menuIcon(ref,FontAwesomeIcons.music, 1),
                  const SizedBox(
                    height: 25.0,
                  ),

                  _menuIcon(ref,FontAwesomeIcons.radio, 2),

                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.all(10), // Add margin for spacing around the menu
              padding: const EdgeInsets.all(10), // Add padding inside the menu
              decoration: BoxDecoration(
                color: const Color(0xff1A1E1F), // Adjust the background color and opacity
                borderRadius: BorderRadius.circular(30), // Circular borders for the entire menu
              ),
              child: Column(
                children: [
                  // Second Menu
                  _menuIcon(ref,FontAwesomeIcons.userAstronaut, 3),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _menuIcon(ref,FontAwesomeIcons.personRunning, 4),
                ],
              ),
            ),
          ],
        ),


      ],
    );
  }

  Widget _menuIcon(WidgetRef ref, IconData icon, int index) {
    return Consumer(
      builder: (context, ref, child) {
        final _selectedIconIndex = ref.watch(selectedIconIndexProvider.notifier).state;

        return GestureDetector(
          onTap: () {
            if (index == 4) {
              // Sign out

              ref.read(authNotifierProvider.notifier).signOut();
            }
            if (index == 2) {
              ref.read(selectedIconIndexProvider.notifier).state = index;
              context.go(AppRoutes.dashboard);
            } else {
              ref.read(selectedIconIndexProvider.notifier).state = index;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: _selectedIconIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).secondaryHeaderColor,
              size: 25,
            ),
          ),
        );
      },
    );
  }

}
