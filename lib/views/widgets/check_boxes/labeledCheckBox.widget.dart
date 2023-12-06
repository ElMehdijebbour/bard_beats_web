import 'package:bardbeatsdash/themes/colors.dart';
import 'package:flutter/material.dart';

/// A custom widget that combines a checkbox with a label.
///
/// This widget displays a checkbox followed by a text label, e.g., "Stay Signed In".
class LabeledCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  /// Creates a [LabeledCheckbox].
  ///
  /// [label] is the text that appears next to the checkbox.
  /// [initialValue] is the initial value of the checkbox.
  /// [onChanged] is called when the value of the checkbox changes.
  const LabeledCheckbox({
    Key? key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LabeledCheckboxState createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _toggleChecked() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleChecked,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (bool? newValue) {
              if (newValue != null) {
                _toggleChecked();
              }
            },
            activeColor: Theme.of(context)
                .primaryColor, // Active color as primary color of the theme
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (!states.contains(MaterialState.selected)) {
                  return AppColors.greyColor; // Non-active color
                }
                return Theme.of(context)
                    .primaryColor; // Otherwise, use the active color
              },
            ),
            side: BorderSide.none, // Removes the border
          ),
          Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xff3C3C41),
            ),
          ),
        ],
      ),
    );
  }
}
