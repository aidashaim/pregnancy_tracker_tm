class SizeUnit {
  String stringCode;

  SizeUnit(this.stringCode);

  SizeUnit._(this.stringCode);

  static final SizeUnit centimeter = SizeUnit._('CENTIMETER');
  static final SizeUnit inch = SizeUnit._('INCH');

  static List<String> allUnits = [SizeUnit.centimeter.getRusName(), SizeUnit.inch.getRusName()];

  static final Map<String, SizeUnit> _values = {
    centimeter.stringCode: centimeter,
    inch.stringCode: inch,
  };

  static final Map<String, SizeUnit> _valuesRus = {
    'Сантиметры': centimeter,
    'Дюймы': inch,
  };

  String getRusName() {
    switch (stringCode) {
      case 'CENTIMETER':
        return 'Сантиметры';
      default:
        return 'Дюймы';
    }
  }

  String getShortRusName() {
    switch (stringCode) {
      case 'CENTIMETER':
        return 'см';
      default:
        return 'дм';
    }
  }

  static SizeUnit getByName(String name) {
    SizeUnit? find;
    _values.forEach((key, value) {
      if (key == name) find = _values[key];
    });
    return find ?? SizeUnit.centimeter;
  }

  static SizeUnit getByRus(String name) {
    SizeUnit? find;
    _valuesRus.forEach((key, value) {
      if (key == name) find = _valuesRus[key];
    });
    return find ?? SizeUnit.centimeter;
  }
}
