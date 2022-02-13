import 'package:flutter/material.dart';
import 'package:pregnancy_tracker_tm/models/movement_counter_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class MovementCounterItem extends StatelessWidget {
  final MovementCounterModel movement;

  const MovementCounterItem({required this.movement, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _period = '';
    if (movement.period ~/ 60 > 0) _period = '${movement.period ~/ 60} ч.';
    if (movement.period % 60 > 0) _period += ' ${movement.period % 60} мин.';
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            UtilFormatters.shortDateMonth(movement.date),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            UtilFormatters.time(movement.items.first.start),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            UtilFormatters.time(movement.items.last.end),
            textAlign: TextAlign.center,
            style: UtilTextStyles.mastersTitle,
          ),
        ),
        Expanded(flex: 2, child: Text(_period, textAlign: TextAlign.center, style: UtilTextStyles.mastersTitle)),
        Expanded(
          flex: 1,
          child: Text(movement.count.toString(), textAlign: TextAlign.center, style: UtilTextStyles.mastersTitle),
        ),
      ],
    );
  }
}
