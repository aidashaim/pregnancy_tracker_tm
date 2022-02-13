import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/my_weight_model.dart';
import 'package:pregnancy_tracker_tm/models/size_model.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/tummy_size_model.dart';
import 'package:pregnancy_tracker_tm/models/user_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/repositories/tummy_size_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';
import 'my_weight_repository.dart';

class UserRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  late UserModel currentUser;

  int getPregnancyDays(DateTime date) => UtilRepo.pregnancyDuration - currentUser.dateOfBirth.difference(date).inDays;

  Future<void> setCurrentUser(UserModel user) async {
    currentUser = user;
    await _storage.box.write(UtilStorage.currentUser, user.toJSON());
  }

  Future<void> setCurrentWeight(WeightModel weightCurrent) async {
    await setCurrentUser(currentUser.copyWith(weightCurrent: weightCurrent));
    await myWeightRepository.addMyWeights(
      weight: MyWeightModel(
        date: UtilFormatters.date(DateTime.now()),
        term: UtilFormatters.gestationalAge(term: currentUser.gestationalAge, short: true),
        unit: weightCurrent.units,
        weight: weightCurrent.weight,
        increase: currentUser.weightBeforePregnancy != null
            ? weightCurrent.weight - currentUser.weightBeforePregnancy!.weight
            : 0,
        days: currentUser.gestationalAge.toDouble(),
        value: weightCurrent.weight,
      ),
    );
  }

  Future<void> setWeightBeforePregnancy(WeightModel weightBeforePregnancy) async {
    await setCurrentUser(currentUser.copyWith(weightBeforePregnancy: weightBeforePregnancy));
    await myWeightRepository.addMyWeights(
      weight: MyWeightModel(
        date: UtilFormatters.date(DateTime.now().subtract(Duration(days: currentUser.gestationalAge))),
        term: UtilFormatters.gestationalAge(term: 1, short: true),
        unit: weightBeforePregnancy.units,
        weight: weightBeforePregnancy.weight,
        increase: 0,
        days: 1,
        value: weightBeforePregnancy.weight,
      ),
    );
  }

  Future<void> setWeightUnit(WeightUnit weightUnit) async {
    if (currentUser.weightBeforePregnancy != null) {
      currentUser.weightBeforePregnancy!.units = weightUnit;
      currentUser.weightBeforePregnancy!.weight = weightUnit == WeightUnit.kilogram
          ? currentUser.weightBeforePregnancy!.weight * 2.204
          : currentUser.weightBeforePregnancy!.weight * .453;
    }

    if (currentUser.weightCurrent != null) {
      currentUser.weightCurrent!.units = weightUnit;
      currentUser.weightCurrent!.weight = weightUnit == WeightUnit.kilogram
          ? currentUser.weightCurrent!.weight * 2.204
          : currentUser.weightCurrent!.weight * .453;
    }
    currentUser.weightUnits = weightUnit;
    await _storage.box.write(UtilStorage.currentUser, currentUser.toJSON());

    List<MyWeightModel> list = myWeightRepository.weights;
    for (var weight in list) {
      weight.weight = weightUnit == WeightUnit.kilogram ? weight.weight * 2.204 : weight.weight * .453;
      weight.unit = weightUnit;
      weight.value = weightUnit == WeightUnit.kilogram ? weight.value * 2.204 : weight.value * .453;
      weight.increase = weightUnit == WeightUnit.kilogram ? weight.increase * 2.204 : weight.increase * .453;
    }
    myWeightRepository.weights = list;
    myWeightRepository.saveToStorage();
  }

  Future<void> setCurrentTummySize(SizeModel tummySizeCurrent) async {
    await setCurrentUser(currentUser.copyWith(tummySizeCurrent: tummySizeCurrent));
    await tummySizeRepository.addTummySize(
      size: TummySizeModel(
        date: UtilFormatters.date(DateTime.now()),
        term: UtilFormatters.gestationalAge(term: currentUser.gestationalAge, short: true),
        unit: tummySizeCurrent.units,
        girth: tummySizeCurrent.tummySize,
        increase: currentUser.tummySizeBeforePregnancy != null
            ? tummySizeCurrent.tummySize - currentUser.tummySizeBeforePregnancy!.tummySize
            : 0,
        days: currentUser.gestationalAge.toDouble(),
        size: tummySizeCurrent.tummySize,
      ),
    );
  }

  Future<void> setTummySizeBeforePregnancy(SizeModel tummySizeBeforePregnancy) async {
    await setCurrentUser(currentUser.copyWith(tummySizeBeforePregnancy: tummySizeBeforePregnancy));
    await tummySizeRepository.addTummySize(
      size: TummySizeModel(
        date: UtilFormatters.date(DateTime.now().subtract(Duration(days: currentUser.gestationalAge))),
        term: UtilFormatters.gestationalAge(term: 1, short: true),
        unit: tummySizeBeforePregnancy.units,
        girth: tummySizeBeforePregnancy.tummySize,
        increase: 0,
        days: 1,
        size: tummySizeBeforePregnancy.tummySize,
      ),
    );
  }

  Future<void> setTummySizeUnit(SizeUnit sizeUnit) async {
    if (currentUser.tummySizeBeforePregnancy != null) {
      currentUser.tummySizeBeforePregnancy!.units = sizeUnit;
      currentUser.tummySizeBeforePregnancy!.tummySize = sizeUnit == SizeUnit.centimeter
          ? currentUser.tummySizeBeforePregnancy!.tummySize * 2.54
          : currentUser.tummySizeBeforePregnancy!.tummySize * .394;
    }

    if (currentUser.tummySizeCurrent != null) {
      currentUser.tummySizeCurrent!.units = sizeUnit;
      currentUser.tummySizeCurrent!.tummySize = sizeUnit == SizeUnit.centimeter
          ? currentUser.tummySizeCurrent!.tummySize * 2.54
          : currentUser.tummySizeCurrent!.tummySize * .394;
    }
    currentUser.sizeUnits = sizeUnit;
    await _storage.box.write(UtilStorage.currentUser, currentUser.toJSON());

    List<TummySizeModel> list = tummySizeRepository.sizes;
    for (var size in list) {
      size.size = sizeUnit == SizeUnit.centimeter ? size.size * 2.54 : size.size * .394;
      size.unit = sizeUnit;
      size.girth = sizeUnit == SizeUnit.centimeter ? size.girth * 2.54 : size.girth * .394;
      size.increase = sizeUnit == SizeUnit.centimeter ? size.increase * 2.54 : size.increase * .394;
    }
    tummySizeRepository.sizes = list;
    tummySizeRepository.saveToStorage();
  }

  Future<void> setDateOfBirth(DateTime date) async {
    int days = UtilRepo.pregnancyDuration - date.difference(DateTime.now()).inDays;
    int gestationalAge = days > UtilRepo.pregnancyDuration ? UtilRepo.pregnancyDuration : days;
    int currentWeek = gestationalAge ~/ 7;
    await setCurrentUser(
        currentUser.copyWith(dateOfBirth: date, gestationalAge: gestationalAge, currentWeek: currentWeek));
  }

  Future<void> setProUser(bool isPro) async {
    await setCurrentUser(currentUser.copyWith(isPro: isPro));
  }
}

UserRepository userRepository = UserRepository();
