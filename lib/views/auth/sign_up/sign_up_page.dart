import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/router/routes.dart';
import 'package:bardbeatsdash/views/auth/sign_up/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          // Navigate to home or another screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Authenticated'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.go(AppRoutes.home);
        },
        unauthenticated: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message!),
                behavior: SnackBarBehavior.floating,
              ),
            ),
      );
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: SvgPicture.asset(
                      "logo/logo_vf.svg",
                      width: 10.w,
                      height: 10.h,
                    ),
                  ),
                  SignUpFormView(
                    formKey: _formKey,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Image.asset(
                'assets/images/bard_splash1.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
