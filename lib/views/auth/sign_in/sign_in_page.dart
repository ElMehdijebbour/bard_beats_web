import 'package:bardbeatsdash/router/routes.dart';
import 'package:bardbeatsdash/views/widgets/headerAndsubtitle.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import 'widgets/sign_in_form_view.dart';

/// this is the log in page UI
///

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Expanded(
              flex: 3, // Adjust this as needed
              child: Stack(
                children: [
                  ListView(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Image.asset(
                          "logo/logo.png",
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SignInFormView(
                          formKey: _formKey,
                          ),
                    ],
                  ),
                  _buildBottomTexts(context)
                ],
              ),
            ),
            Expanded(
              flex: 7, // Adjust the flex ratio to control width of the sections
              child: Image.asset(
                'assets/images/bard_splash1.jpg',
                fit: BoxFit
                    .cover, // This ensures the image covers the full height
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomTexts(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 20), // Adjust the padding as needed
        child: Column(
          mainAxisSize: MainAxisSize.min, // Takes the minimum space it can
          children: [
            GestureDetector(
              onTap: () {
                // TODO: Implement tap functionality for "Can't Sign In"
              },
              child: const Text(
                "CAN'T SIGN IN?",
                style: TextStyle(
                  color: Colors
                      .grey, // Use your theme color or customize as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between the two texts
            GestureDetector(
              child: const Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  color: Colors
                      .grey, // Use your theme color or customize as needed // Use your theme color or customize as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                context.go(AppRoutes.signUp);
              },
            ),
          ],
        ),
      ),
    );
  }
}
