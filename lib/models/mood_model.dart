import 'package:pregnancy_tracker_tm/utils/util_icons.dart';

class MoodModel {
  String stringCode;

  MoodModel(this.stringCode);

  MoodModel._(this.stringCode);

  static final MoodModel happy = MoodModel._('HAPPY');
  static final MoodModel love = MoodModel._('LOVE');
  static final MoodModel glad = MoodModel._('GLAD');
  static final MoodModel facepalm = MoodModel._('FACEPALM');
  static final MoodModel cry = MoodModel._('CRY');
  static final MoodModel nausea = MoodModel._('NAUSEA');

  static List<MoodModel> get allMoods => [
        MoodModel.happy,
        MoodModel.love,
        MoodModel.glad,
        MoodModel.facepalm,
        MoodModel.cry,
        MoodModel.nausea,
      ];

  static final Map<String, String> mapIcons = {
    happy.stringCode: UtilIcons.mood0,
    love.stringCode: UtilIcons.mood1,
    glad.stringCode: UtilIcons.mood2,
    facepalm.stringCode: UtilIcons.mood3,
    cry.stringCode: UtilIcons.mood4,
    nausea.stringCode: UtilIcons.mood5,
  };

  static final Map<String, MoodModel> _values = {
    happy.stringCode: happy,
    love.stringCode: love,
    glad.stringCode: glad,
    facepalm.stringCode: facepalm,
    cry.stringCode: cry,
    nausea.stringCode: nausea,
  };

  static MoodModel getByName(String name) {
    MoodModel? find;
    _values.forEach((key, value) {
      if (key == name) find = _values[key];
    });
    return find ?? MoodModel.happy;
  }
}
