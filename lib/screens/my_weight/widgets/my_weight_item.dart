import 'package:flutter/material.dart';
import 'package:pregnancy_tracker_tm/models/my_weight_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class MyWeightItem extends StatelessWidget {
  final MyWeightModel weight;

  const MyWeightItem({required this.weight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(weight.date, textAlign: TextAlign.center, style: UtilTextStyles.mastersTitle)),
        Expanded(flex: 3, child: Text(weight.term, textAlign: TextAlign.center, style: UtilTextStyles.mastersTitle)),
        Expanded(
          flex: 2,
          child: Text(
            weight.weight.toStringAsFixed(2) + ' ' + weight.unit.getShortRusName(),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            weight.increase.toStringAsFixed(2) + ' ' + weight.unit.getShortRusName(),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
      ],
    );
  }
}
