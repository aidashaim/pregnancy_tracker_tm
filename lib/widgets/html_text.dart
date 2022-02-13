import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_fonts.dart';

class HtmlText extends StatelessWidget {
  final String text;

  const HtmlText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text,
      style: {
        'p': Style(
          fontFamily: UtilFonts.raleway,
          color: UtilColors.darkGrey.withOpacity(.75),
          fontWeight: FontWeight.w500,
        ),
        'li': Style(
          fontFamily: UtilFonts.raleway,
          color: UtilColors.darkGrey.withOpacity(.75),
          fontWeight: FontWeight.w500,
        ),
      },
    );
  }
}
