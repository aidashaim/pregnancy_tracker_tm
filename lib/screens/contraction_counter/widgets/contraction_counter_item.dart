import 'package:flutter/material.dart';
import 'package:pregnancy_tracker_tm/models/contraction_counter_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class ContractionCounterItem extends StatelessWidget {
  final ContractionCounterModel contraction;
  final bool isTitle;

  const ContractionCounterItem({required this.contraction, this.isTitle = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            contraction.start,
            textAlign: TextAlign.center,
            style: isTitle ? UtilTextStyles.greyTextDesc : UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            contraction.end,
            textAlign: TextAlign.center,
            style: isTitle ? UtilTextStyles.greyTextDesc : UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            contraction.duration,
            textAlign: TextAlign.center,
            style: isTitle ? UtilTextStyles.greyTextDesc : UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            contraction.interval,
            textAlign: TextAlign.center,
            style: isTitle ? UtilTextStyles.greyTextDesc : UtilTextStyles.mastersTitle,
          ),
        ),
      ],
    );
  }
}
