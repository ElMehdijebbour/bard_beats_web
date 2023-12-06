import 'package:flutter/material.dart';

/// A custom square sign-in button with a central arrow.
///
/// The button's style changes based on the [isActive] flag.
class SignInButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isActive;
  final bool isLoading;

  /// Creates a [SignInButton].
  ///
  /// [onTap] is the function executed when the button is tapped.
  /// [isActive] determines the button's style.
  const SignInButton({
    Key? key,
    this.onTap,
    this.isActive = false, required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive && !isLoading ? onTap : null, // Only allow tapping if the button is active.
      child:  Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Icon(Icons.arrow_forward, color: isActive ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
