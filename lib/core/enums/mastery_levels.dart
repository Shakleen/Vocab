import 'package:flutter/material.dart';

enum MasteryLevels {
  Untouched,
  Learning,
  Familiar,
  Proficient,
  Mastered,
}

const MASTERY_LEVELS = 5;
const int LEARNING_LEVEL_START = 1;
const int FAMILIAR_LEVEL_START = 3;
const int PROFICIENT_LEVEL_START = 10;
const int MASTERED_LEVEL_START = 16;

const Map<MasteryLevels, int> MASTERY_LEVEL_TO_ID = const {
  MasteryLevels.Untouched: 0,
  MasteryLevels.Learning: 1,
  MasteryLevels.Familiar: 2,
  MasteryLevels.Proficient: 3,
  MasteryLevels.Mastered: 4,
};

const Map<int, MasteryLevels> ID_TO_MASTERY_LEVEL = const {
  0: MasteryLevels.Untouched,
  1: MasteryLevels.Learning,
  2: MasteryLevels.Familiar,
  3: MasteryLevels.Proficient,
  4: MasteryLevels.Mastered,
};

const Map<MasteryLevels, Color> MASTERY_LEVEL_COLOR = const {
  MasteryLevels.Untouched: Colors.grey,
  MasteryLevels.Learning: Colors.yellow,
  MasteryLevels.Familiar: Colors.lightGreen,
  MasteryLevels.Proficient: Colors.green,
  MasteryLevels.Mastered: Color(0xff1b5e20),
};

String getMasteryLevelString(MasteryLevels level) =>
    level.toString().split('.').last;

MasteryLevels getMasteryLevelForLevel(int level) {
  if (level < LEARNING_LEVEL_START) return MasteryLevels.Untouched;
  else if (level >= LEARNING_LEVEL_START && level < FAMILIAR_LEVEL_START) return MasteryLevels.Learning;
  else if (level >= FAMILIAR_LEVEL_START && level < PROFICIENT_LEVEL_START) return MasteryLevels.Familiar;
  else if (level >= PROFICIENT_LEVEL_START && level < MASTERED_LEVEL_START) return MasteryLevels.Proficient;
  else return MasteryLevels.Mastered;
}

Duration getDurationForMasteryLevel(int level) {
  if (level < LEARNING_LEVEL_START) return Duration(minutes: 1);
  else if (level >= LEARNING_LEVEL_START && level < FAMILIAR_LEVEL_START) return Duration(minutes: 2);
  else return Duration(days: 2 * (level - FAMILIAR_LEVEL_START) + 1);
}