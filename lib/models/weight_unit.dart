class WeightUnit {
  String stringCode;

  WeightUnit(this.stringCode);

  WeightUnit._(this.stringCode);

  static final WeightUnit kilogram = WeightUnit._('KILOGRAM');
  static final WeightUnit pound = WeightUnit._('POUND');

  static List<String> allUnits = [WeightUnit.kilogram.getRusName(), WeightUnit.pound.getRusName()];

  static final Map<String, WeightUnit> _values = {
    kilogram.stringCode: kilogram,
    pound.stringCode: pound,
  };

  static final Map<String, WeightUnit> _valuesRus = {
    'Килограммы': kilogram,
    'Фунты': pound,
  };

  String getRusName() {
    switch (stringCode) {
      case 'KILOGRAM':
        return 'Килограммы';
      default:
        return 'Фунты';
    }
  }

  String getShortRusName() {
    switch (stringCode) {
      case 'KILOGRAM':
        return 'кг';
      default:
        return 'фт';
    }
  }

  static WeightUnit getByName(String name) {
    WeightUnit? find;
    _values.forEach((key, value) {
      if (key == name) find = _values[key];
    });
    return find ?? WeightUnit.kilogram;
  }

  static WeightUnit getByRus(String name) {
    WeightUnit? find;
    _valuesRus.forEach((key, value) {
      if (key == name) find = _valuesRus[key];
    });
    return find ?? WeightUnit.kilogram;
  }
}
