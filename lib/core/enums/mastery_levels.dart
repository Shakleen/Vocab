enum MasteryLevels {
  Untouched,
  Learning,
  Familiar,
  Mastered,
}

const MASTERY_LEVELS = 4;
const int LEARNING_LEVEL_START = 1;
const int FAMILIAR_LEVEL_START = 6;
const int MASTERED_LEVEL_START = 24;

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
  if (level < LEARNING_LEVEL_START) return MasteryLevels.Untouched;
  else if (level >= LEARNING_LEVEL_START && level < FAMILIAR_LEVEL_START) return MasteryLevels.Learning;
  else if (level >= FAMILIAR_LEVEL_START && level < MASTERED_LEVEL_START) return MasteryLevels.Familiar;
  else return MasteryLevels.Mastered;
}