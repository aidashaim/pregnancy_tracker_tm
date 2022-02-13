import 'package:flutter/material.dart';
import 'package:pregnancy_tracker_tm/models/tummy_size_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class TummySizeItem extends StatelessWidget {
  final TummySizeModel size;

  const TummySizeItem({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            size.date,
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            size.term,
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            size.girth.toStringAsFixed(2) + ' ' + size.unit.getShortRusName(),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            size.increase.toStringAsFixed(2) + ' ' + size.unit.getShortRusName(),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
      ],
    );
  }
}
