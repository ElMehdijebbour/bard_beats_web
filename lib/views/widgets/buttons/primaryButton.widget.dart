import 'package:flutter/material.dart';


/// The primary button of the application
/// can be used in many places: auth, Saving changes ...

class PrimaryButton extends StatelessWidget {

  /// The button params
  final String textButton;
  final String? iconButton;
  final VoidCallback onClick;
  final Color buttonColor;
  const PrimaryButton({super.key,
    required this.onClick,
    required this.buttonColor,
    this.iconButton,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        highlightColor: buttonColor,
        onTap: onClick,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconButton == null ? const SizedBox():Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                      iconButton!
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    textButton,
                    textAlign: iconButton == null ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10
                    ),

                    maxLines: 1,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
