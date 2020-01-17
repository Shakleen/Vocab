enum MasteryLevels {
  Untouched,
  Learning,
  Mastered,
}

const Map<MasteryLevels, int> MASTERY_LEVEL_TO_ID = const {
  MasteryLevels.Untouched: 0,
  MasteryLevels.Learning: 1,
  MasteryLevels.Mastered: 2,
};


const Map<int, MasteryLevels> ID_TO_MASTERY_LEVEL = const {
  0: MasteryLevels.Untouched,
  1: MasteryLevels.Learning,
  2: MasteryLevels.Mastered,
};

String getMasteryLevelString(MasteryLevels level) =>
    level.toString().split('.').last;

MasteryLevels getMasteryLevelForLevel(int level) {
  if (level <= 0) return MasteryLevels.Untouched;
  else if (level > 0 && level < 21) return MasteryLevels.Learning;
  else return MasteryLevels.Mastered;
}