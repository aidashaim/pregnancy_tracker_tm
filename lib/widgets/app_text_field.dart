import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final String? helpText;
  final TextEditingController? controller;
  final TextInputType? type;
  final int? minLines;
  final bool withBorder;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    this.hint = '',
    this.helpText,
    this.controller,
    this.type,
    this.minLines,
    this.withBorder = false,
    this.maxLines,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  factory AppTextField.large({
    required String hint,
    required TextEditingController controller,
  }) {
    return AppTextField(controller: controller, hint: hint, minLines: 6, withBorder: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (helpText != null)
          Padding(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Text(helpText!, style: UtilTextStyles.dropDownHint),
          ),
        Container(
          width: double.maxFinite,
          height: minLines == null ? 48.w : null,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: withBorder ? UtilColors.textFieldGrey : Colors.white,
            borderRadius: BorderRadius.circular(withBorder ? 5.w : 12.w),
            border: withBorder ? Border.all(color: UtilColors.navigationGrey) : null,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: type,
            minLines: minLines,
            maxLines: maxLines ?? minLines,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: UtilTextStyles.dropDownTitle,
            ),
          ),
        ),
      ],
    );
  }
}
