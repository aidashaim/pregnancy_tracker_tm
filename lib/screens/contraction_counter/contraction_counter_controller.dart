import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracker_tm/models/contraction_counter_model.dart';
import 'package:pregnancy_tracker_tm/repositories/contraction_counter_repository.dart';

class ContractionCounterController extends GetxController {
  RxList<ContractionCounterModel> contractions = contractionCounterRepository.contractions.obs;
  final RxBool contractionStarted = false.obs;
  final RxString timerContractionText = '00:00'.obs;
  final RxString timerIntervalText = '00:00'.obs;

  int _startTime = 0;
  int? interval;
  Timer? _timer;
  late DateTime contractionStart;

  void startTimer(bool isContraction) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        _startTime++;
        if (isContraction) {
          timerContractionText.value = '00:${_startTime > 9 ? _startTime.toString() : '0' + _startTime.toString()}';
        } else {
          timerIntervalText.value = '00:${_startTime > 9 ? _startTime.toString() : '0' + _startTime.toString()}';
        }
      },
    );
  }

  void stopTimer(bool isContraction) {
    _timer!.cancel();

    if (isContraction) {
      timerContractionText.value = '00:00';
    } else {
      timerIntervalText.value = '00:00';
      interval = _startTime;
    }
    _startTime = 0;
  }

  void startContraction() {
    contractionStarted.value = !contractionStarted.value;
    contractionStart = DateTime.now();
    if (_timer != null) {
      stopTimer(false);
    }
    startTimer(true);
  }

  void stopContraction() {
    contractionStarted.value = !contractionStarted.value;
    DateTime end = DateTime.now();
    stopTimer(true);
    startTimer(false);

    String _start = DateFormat(DateFormat.HOUR24_MINUTE).format(contractionStart);
    String _end = DateFormat(DateFormat.HOUR24_MINUTE).format(end);
    int _durationSeconds = end.difference(contractionStart).inSeconds;
    String _interval = '';
    String _duration = '';
    if (interval != null) {
      int _intervalSeconds = end.difference(contractionStart).inSeconds;
      if (_intervalSeconds ~/ 60 > 0) _interval = '${_intervalSeconds ~/ 60} мин.';
      if (_intervalSeconds % 60 > 0) _interval += ' ${_intervalSeconds % 60} сек.';
    }

    if (_durationSeconds ~/ 60 > 0) _duration = '${_durationSeconds ~/ 60} мин.';
    if (_durationSeconds % 60 > 0) _duration += ' ${_durationSeconds % 60} сек.';

    ContractionCounterModel contraction = ContractionCounterModel(
      start: _start,
      end: _end,
      duration: _duration,
      interval: _interval.isNotEmpty ? _interval : '-',
    );
    addContraction(contraction);
  }

  Future<void> addContraction(ContractionCounterModel contraction) async {
    await contractionCounterRepository.addContraction(contraction: contraction);
    contractions.value = contractionCounterRepository.contractions;
    contractions.refresh();
  }
}
