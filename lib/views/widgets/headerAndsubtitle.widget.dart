
import 'package:flutter/material.dart';

/// This is the header and the subtitle of the pages
/// can be used in places: Login, Sign Up, Reset password, Search ...

class HeaderAndSubtitle extends StatelessWidget {

  /// the widget properties
  final String header;
  final String subTitle;
  final double? headerSize;
  final double? subTitleSize;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextAlign? align;
  final FontWeight? headerFontWeight;
  final Color? headerTextColor;
  /// the widget default constructor
  const HeaderAndSubtitle(
      {
        super.key,
        required this.header,
        required this.subTitle,
        this.headerSize,
        this.subTitleSize,
        this.crossAxisAlignment,
        this.align,
        this.headerFontWeight,
        this.headerTextColor,
      }
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Text(
          header,
          textAlign: align ?? TextAlign.center,
          style: TextStyle(
            fontSize: headerSize ?? 25,
            fontWeight: headerFontWeight ?? FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),

        ),
        Text(
            subTitle,
            textAlign: align ?? TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: subTitleSize ?? 10
            )
        )
      ],
    );
  }
}
