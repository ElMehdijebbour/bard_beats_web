import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/features/auth/providers/state/sign_up_form_validator.dart';
import 'package:bardbeatsdash/router/routes.dart';
import 'package:bardbeatsdash/views/widgets/buttons/signInButton.widget.dart';
import 'package:bardbeatsdash/views/widgets/buttons/socialIconButtonn.widget.dart';
import 'package:bardbeatsdash/views/widgets/check_boxes/labeledCheckBox.widget.dart';
import 'package:bardbeatsdash/views/widgets/inputs/input.widget.dart';
import 'package:bardbeatsdash/views/widgets/inputs/inputpassword.widget.dart';
import 'package:bardbeatsdash/views/widgets/inputs/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your widgets and validators here

class SignUpFormView extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUpFormView({Key? key, required this.formKey}) : super(key: key);

  @override
  ConsumerState<SignUpFormView> createState() => _SignUpFormViewState();
}

class _SignUpFormViewState extends ConsumerState<SignUpFormView> {
  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(() => validateForm());
    widget.passwordController.addListener(() => validateForm());
    widget.confirmPasswordController.addListener(() => validateForm());
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.confirmPasswordController.dispose();
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Authenticated'),
              behavior: SnackBarBehavior.floating,
            ),
          );
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
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Adjust padding as needed
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
                  inputValidator: PasswordValidator(),
                  onChanged: (String) {},
                ),
                const SizedBox(height: 20),
                InputPasswordWidget(
                  inputController: widget.confirmPasswordController,
                  hintText: 'Confirm Password',
                  inputValidator:
                      ConfirmPasswordValidator(widget.passwordController),
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
                const SizedBox(
                  height: 70.0,
                ),
                Center(
                  child: SignInButton(
                    onTap: () {
                      if (ref.watch(formValidationProvider)) {
                        // Use the provided text controllers to get the user input
                        final String email = widget.emailController.text;
                        final String password = widget.passwordController.text;

                        // Call the signup method from your auth notifier
                        ref
                            .read(authNotifierProvider.notifier)
                            .signup(email: email, password: password);
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
    );
  }
}
