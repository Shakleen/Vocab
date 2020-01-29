enum MasteryLevels {
  Untouched,
  Learning,
  Familiar,
  Mastered,
}

const Map<MasteryLevels, int> MASTERY_LEVEL_TO_ID = const {
  MasteryLevels.Untouched: 0,
  MasteryLevels.Learning: 1,
  MasteryLevels.Familiar: 2,
  MasteryLevels.Mastered: 3,
};


const Map<int, MasteryLevels> ID_TO_MASTERY_LEVEL = const {
  0: MasteryLevels.Untouched,
  1: MasteryLevels.Learning,
  2: MasteryLevels.Familiar,
  3: MasteryLevels.Mastered,
};

String getMasteryLevelString(MasteryLevels level) =>
    level.toString().split('.').last;

MasteryLevels getMasteryLevelForLevel(int level) {
  if (level <= 0) return MasteryLevels.Untouched;
  else if (level > 0 && level <= 10) return MasteryLevels.Learning;
  else if (level > 10 && level < 25) return MasteryLevels.Familiar;
  else return MasteryLevels.Mastered;
}