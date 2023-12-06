import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/features/auth/providers/state/sign_up_form_validator.dart';
import 'package:bardbeatsdash/router/routes.dart';
import 'package:bardbeatsdash/views/widgets/buttons/signInButton.widget.dart';
import 'package:bardbeatsdash/views/widgets/check_boxes/labeledCheckBox.widget.dart';
import 'package:bardbeatsdash/views/widgets/inputs/input.widget.dart';
import 'package:bardbeatsdash/views/widgets/inputs/inputpassword.widget.dart';
import 'package:bardbeatsdash/views/widgets/inputs/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/buttons/socialIconButtonn.widget.dart';

class SignInFormView extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInFormView({Key? key, required this.formKey}) : super(key: key);

  @override
  ConsumerState<SignInFormView> createState() => _SignInFormViewState();
}

class _SignInFormViewState extends ConsumerState<SignInFormView> {
  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(() => validateForm());
    widget.passwordController.addListener(() => validateForm());
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

  void validateForm() {
    ref.read(formValidationProvider.notifier).validateForm(widget.formKey);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          // Navigate to any screen
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'BardBeats',
              message:
              'Welcome back summoner!',
              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          context.go(AppRoutes.home);
        },
        unauthenticated: (message) {
          // Navigate to any screen
          final snackBar = SnackBar(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'BardBeats',
              message:
              message!,
              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
      );
    });

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputWidget(
                    inputController: widget.emailController,
                    hintText: 'Email',
                    inputValidator: EmailValidator(),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  InputPasswordWidget(
                    inputController: widget.passwordController,
                    hintText: 'Password',
                    inputValidator: EmptyValidator(),
                    onChanged: (String) {},
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialIconButton(
                        onTap: () {
                          // Handle Facebook button tap
                        },
                        iconColor: Colors.white,
                        backgroundColor: const Color(0xff3678EA),
                        iconAssetPath: 'assets/icons/facebook_icon.png',
                      ),
                      SocialIconButton(
                        onTap: () {
                          // Handle Google button tap
                        },
                        backgroundColor: Colors.white,
                        iconAssetPath: 'assets/icons/google_icon.png',
                      ),
                      SocialIconButton(
                        onTap: () {
                          // Handle Apple button tap
                        },
                        iconColor: Colors.white,
                        backgroundColor: Colors.black,
                        iconAssetPath: 'assets/icons/apple_icon.png',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  LabeledCheckbox(
                    label: 'Stay signed in',
                    initialValue: true, // or false, depending on your needs
                    onChanged: (bool newValue) {
                      // Handle the change in checkbox state
                      print('Checkbox is now: $newValue');
                    },
                  ),
                  // const SizedBox(
                  //   height: 70.0,
                  // ),
                  Center(
                    child: SignInButton(
                      onTap: () {
                        if (ref.watch(formValidationProvider)) {
                          final String email = widget.emailController.text;
                          final String password = widget.passwordController.text;
                          ref
                              .read(authNotifierProvider.notifier)
                              .login(email: email, password: password);
                        }
                      },
                      isActive: ref.watch(formValidationProvider),
                      isLoading: ref.watch(authNotifierProvider).maybeWhen(
                        orElse: () => false,
                        loading: () => true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
