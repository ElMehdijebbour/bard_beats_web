


import 'package:bardbeatsdash/themes/colors.dart';
import 'package:bardbeatsdash/views/widgets/inputs/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// The basic input field, must be inherited to implement the other fields
/// can be used in many places: email, phone, name changes ...
class InputWidget extends StatefulWidget {

  /// Input widget
  /// * 2022
  /// * [Update] updated on 16/08/2022 by Vandeatta
  /// * [inputController] controller for text fields must be disposed after use !
  /// * [hintText] hint text to show to help the user
  /// * [inputIcon] icon at the left of the field
  /// * [keyboardType] used to precise what type of keyboard is used for [inputText]
  /// * [inputValidator] used to validate user entries



  final TextEditingController? inputController;
  final String hintText;
  final IconData? inputIcon;
  final TextInputType? keyboardType;
  final InputValidator inputValidator;
  final String? headerText;
  final void Function(String)? onChanged;
  /// Function to be run when user clicks on the widget (icon + hint ..)
  /// When [onClick] is not null, the input will be disabled, and only the click effect would work.
  final void Function()? onClick;
  const InputWidget(
      {super.key,
        required this.inputController,
        required this.hintText,
        this.inputIcon,
        required this.inputValidator,
        this.keyboardType,
        this.onClick,
        this.headerText, this.onChanged,
      });

  @override
  InputWidgetState createState() => InputWidgetState();
}

class InputWidgetState extends State<InputWidget> {
  String? errorText;

  void validateAndChangeErrorText(String? text, BuildContext context) {
    setState(() => errorText = widget.inputValidator.validate(text, context));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onClick,
          child: TextFormField(
            onChanged: widget.onChanged,
            enabled: widget.onClick == null,
            validator: (String? argument) => widget.inputValidator.validate(argument, context),
            onFieldSubmitted: (String? argument) => widget.inputValidator.validate(argument, context),
            keyboardType: widget.keyboardType,
            controller: widget.inputController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 2.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3C3C41)
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 25.0),
              suffixIcon: widget.inputIcon != null ? Icon(
                widget.inputIcon,
                color: Theme.of(context).primaryIconTheme.color,
              ) : null,
              filled: true,
              fillColor: const Color(0xffF0F0F0),
              labelText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 3.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),


        ),
      ],
    );
  }
}
