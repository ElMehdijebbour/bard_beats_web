import 'package:bardbeatsdash/themes/colors.dart';
import 'package:flutter/material.dart';

/// A custom button widget for social media icons.
///
/// This button is styled as a rectangular container with rounded borders and an icon at its center.
/// It can be customized for different social media platforms like Google, Facebook, and Apple.
class SocialIconButton extends StatelessWidget {
  /// The function to be called when the button is tapped.
  final VoidCallback? onTap;

  /// The color of the icon.
  final Color? iconColor;

  /// The color of the button's background.
  final Color backgroundColor;

  /// The asset path of the icon.
  final String iconAssetPath;

  /// The elevation of the button.
  final double elevation;

  /// Creates a [SocialIconButton].
  ///
  /// The [onTap] parameter takes a function to be executed when the button is pressed.
  /// [iconColor] and [backgroundColor] allow customization of the button's appearance.
  /// [iconAssetPath] is the path to the icon asset.
  /// [elevation] defines the elevation of the button.
  const SocialIconButton({
    Key? key,
    this.onTap,
    this.iconColor,
    required this.backgroundColor,
    required this.iconAssetPath,
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handle tap event.
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 7.0), // Inner padding for the container.
        decoration: BoxDecoration(
          color: backgroundColor, // Background color of the button.
          borderRadius: BorderRadius.circular(5.0), // Rounded border radius.
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor,
              spreadRadius: elevation,
              blurRadius: elevation,
              offset: Offset(0, elevation), // changes position of shadow
            ),
          ],
        ),
        child: Image.asset(
          iconAssetPath, // Path to the icon in your assets.
          width: 24, // Width of the icon.
          height: 24, // Height of the icon.
          color: iconColor, // Color of the icon.
        ),
      ),
    );
  }
}
