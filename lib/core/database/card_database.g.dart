// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Entry extends DataClass implements Insertable<Entry> {
  final int id;
  final DateTime addedOn;
  final String pronunciation;
  final int wordId;
  Entry(
      {this.id,
      @required this.addedOn,
      @required this.pronunciation,
      @required this.wordId});
  factory Entry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Entry(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      addedOn: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}added_on']),
      pronunciation: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pronunciation']),
      wordId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}word_id']),
    );
  }
  factory Entry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<int>(json['id']),
      addedOn: serializer.fromJson<DateTime>(json['addedOn']),
      pronunciation: serializer.fromJson<String>(json['pronunciation']),
      wordId: serializer.fromJson<int>(json['wordId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'addedOn': serializer.toJson<DateTime>(addedOn),
      'pronunciation': serializer.toJson<String>(pronunciation),
      'wordId': serializer.toJson<int>(wordId),
    };
  }

  @override
  EntriesCompanion createCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      addedOn: addedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(addedOn),
      pronunciation: pronunciation == null && nullToAbsent
          ? const Value.absent()
          : Value(pronunciation),
      wordId:
          wordId == null && nullToAbsent ? const Value.absent() : Value(wordId),
    );
  }

  Entry copyWith(
          {int id, DateTime addedOn, String pronunciation, int wordId}) =>
      Entry(
        id: id ?? this.id,
        addedOn: addedOn ?? this.addedOn,
        pronunciation: pronunciation ?? this.pronunciation,
        wordId: wordId ?? this.wordId,
      );
  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('addedOn: $addedOn, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('wordId: $wordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(addedOn.hashCode, $mrjc(pronunciation.hashCode, wordId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.addedOn == this.addedOn &&
          other.pronunciation == this.pronunciation &&
          other.wordId == this.wordId);
}

class EntriesCompanion extends UpdateCompanion<Entry> {
  final Value<int> id;
  final Value<DateTime> addedOn;
  final Value<String> pronunciation;
  final Value<int> wordId;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.addedOn = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.wordId = const Value.absent(),
  });
  EntriesCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime addedOn,
    @required String pronunciation,
    @required int wordId,
  })  : addedOn = Value(addedOn),
        pronunciation = Value(pronunciation),
        wordId = Value(wordId);
  EntriesCompanion copyWith(
      {Value<int> id,
      Value<DateTime> addedOn,
      Value<String> pronunciation,
      Value<int> wordId}) {
    return EntriesCompanion(
      id: id ?? this.id,
      addedOn: addedOn ?? this.addedOn,
      pronunciation: pronunciation ?? this.pronunciation,
      wordId: wordId ?? this.wordId,
    );
  }
}

class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entry> {
  final GeneratedDatabase _db;
  final String _alias;
  $EntriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _addedOnMeta = const VerificationMeta('addedOn');
  GeneratedDateTimeColumn _addedOn;
  @override
  GeneratedDateTimeColumn get addedOn => _addedOn ??= _constructAddedOn();
  GeneratedDateTimeColumn _constructAddedOn() {
    return GeneratedDateTimeColumn(
      'added_on',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pronunciationMeta =
      const VerificationMeta('pronunciation');
  GeneratedTextColumn _pronunciation;
  @override
  GeneratedTextColumn get pronunciation =>
      _pronunciation ??= _constructPronunciation();
  GeneratedTextColumn _constructPronunciation() {
    return GeneratedTextColumn(
      'pronunciation',
      $tableName,
      false,
    );
  }

  final VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  GeneratedIntColumn _wordId;
  @override
  GeneratedIntColumn get wordId => _wordId ??= _constructWordId();
  GeneratedIntColumn _constructWordId() {
    return GeneratedIntColumn('word_id', $tableName, false,
        $customConstraints: 'REFERENCES words(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, addedOn, pronunciation, wordId];
  @override
  $EntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'entries';
  @override
  final String actualTableName = 'entries';
  @override
  VerificationContext validateIntegrity(EntriesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.addedOn.present) {
      context.handle(_addedOnMeta,
          addedOn.isAcceptableValue(d.addedOn.value, _addedOnMeta));
    } else if (isInserting) {
      context.missing(_addedOnMeta);
    }
    if (d.pronunciation.present) {
      context.handle(
          _pronunciationMeta,
          pronunciation.isAcceptableValue(
              d.pronunciation.value, _pronunciationMeta));
    } else if (isInserting) {
      context.missing(_pronunciationMeta);
    }
    if (d.wordId.present) {
      context.handle(
          _wordIdMeta, wordId.isAcceptableValue(d.wordId.value, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Entry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EntriesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.addedOn.present) {
      map['added_on'] = Variable<DateTime, DateTimeType>(d.addedOn.value);
    }
    if (d.pronunciation.present) {
      map['pronunciation'] =
          Variable<String, StringType>(d.pronunciation.value);
    }
    if (d.wordId.present) {
      map['word_id'] = Variable<int, IntType>(d.wordId.value);
    }
    return map;
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(_db, alias);
  }
}

class Sense extends DataClass implements Insertable<Sense> {
  final int id;
  final int entryId;
  final int partOfSpeech;
  final String definition;
  Sense(
      {this.id,
      @required this.entryId,
      @required this.partOfSpeech,
      @required this.definition});
  factory Sense.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Sense(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      entryId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}entry_id']),
      partOfSpeech: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}part_of_speech']),
      definition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}definition']),
    );
  }
  factory Sense.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Sense(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      partOfSpeech: serializer.fromJson<int>(json['partOfSpeech']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'partOfSpeech': serializer.toJson<int>(partOfSpeech),
      'definition': serializer.toJson<String>(definition),
    };
  }

  @override
  SensesCompanion createCompanion(bool nullToAbsent) {
    return SensesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      entryId: entryId == null && nullToAbsent
          ? const Value.absent()
          : Value(entryId),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
    );
  }

  Sense copyWith({int id, int entryId, int partOfSpeech, String definition}) =>
      Sense(
        id: id ?? this.id,
        entryId: entryId ?? this.entryId,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        definition: definition ?? this.definition,
      );
  @override
  String toString() {
    return (StringBuffer('Sense(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(entryId.hashCode,
          $mrjc(partOfSpeech.hashCode, definition.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Sense &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.partOfSpeech == this.partOfSpeech &&
          other.definition == this.definition);
}

class SensesCompanion extends UpdateCompanion<Sense> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<int> partOfSpeech;
  final Value<String> definition;
  const SensesCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.definition = const Value.absent(),
  });
  SensesCompanion.insert({
    this.id = const Value.absent(),
    @required int entryId,
    @required int partOfSpeech,
    @required String definition,
  })  : entryId = Value(entryId),
        partOfSpeech = Value(partOfSpeech),
        definition = Value(definition);
  SensesCompanion copyWith(
      {Value<int> id,
      Value<int> entryId,
      Value<int> partOfSpeech,
      Value<String> definition}) {
    return SensesCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definition: definition ?? this.definition,
    );
  }
}

class $SensesTable extends Senses with TableInfo<$SensesTable, Sense> {
  final GeneratedDatabase _db;
  final String _alias;
  $SensesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _entryIdMeta = const VerificationMeta('entryId');
  GeneratedIntColumn _entryId;
  @override
  GeneratedIntColumn get entryId => _entryId ??= _constructEntryId();
  GeneratedIntColumn _constructEntryId() {
    return GeneratedIntColumn('entry_id', $tableName, false,
        $customConstraints: 'REFERENCES entries(id)');
  }

  final VerificationMeta _partOfSpeechMeta =
      const VerificationMeta('partOfSpeech');
  GeneratedIntColumn _partOfSpeech;
  @override
  GeneratedIntColumn get partOfSpeech =>
      _partOfSpeech ??= _constructPartOfSpeech();
  GeneratedIntColumn _constructPartOfSpeech() {
    return GeneratedIntColumn(
      'part_of_speech',
      $tableName,
      false,
    );
  }

  final VerificationMeta _definitionMeta = const VerificationMeta('definition');
  GeneratedTextColumn _definition;
  @override
  GeneratedTextColumn get definition => _definition ??= _constructDefinition();
  GeneratedTextColumn _constructDefinition() {
    return GeneratedTextColumn(
      'definition',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, entryId, partOfSpeech, definition];
  @override
  $SensesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'senses';
  @override
  final String actualTableName = 'senses';
  @override
  VerificationContext validateIntegrity(SensesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (d.partOfSpeech.present) {
      context.handle(
          _partOfSpeechMeta,
          partOfSpeech.isAcceptableValue(
              d.partOfSpeech.value, _partOfSpeechMeta));
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (d.definition.present) {
      context.handle(_definitionMeta,
          definition.isAcceptableValue(d.definition.value, _definitionMeta));
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sense map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Sense.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SensesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.entryId.present) {
      map['entry_id'] = Variable<int, IntType>(d.entryId.value);
    }
    if (d.partOfSpeech.present) {
      map['part_of_speech'] = Variable<int, IntType>(d.partOfSpeech.value);
    }
    if (d.definition.present) {
      map['definition'] = Variable<String, StringType>(d.definition.value);
    }
    return map;
  }

  @override
  $SensesTable createAlias(String alias) {
    return $SensesTable(_db, alias);
  }
}

class Word extends DataClass implements Insertable<Word> {
  final int id;
  final String word;
  Word({this.id, @required this.word});
  factory Word.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Word(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      word: stringType.mapFromDatabaseResponse(data['${effectivePrefix}word']),
    );
  }
  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
    };
  }

  @override
  WordsCompanion createCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      word: word == null && nullToAbsent ? const Value.absent() : Value(word),
    );
  }

  Word copyWith({int id, String word}) => Word(
        id: id ?? this.id,
        word: word ?? this.word,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('word: $word')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, word.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Word && other.id == this.id && other.word == this.word);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> word;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    @required String word,
  }) : word = Value(word);
  WordsCompanion copyWith({Value<int> id, Value<String> word}) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
    );
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  final GeneratedDatabase _db;
  final String _alias;
  $WordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _wordMeta = const VerificationMeta('word');
  GeneratedTextColumn _word;
  @override
  GeneratedTextColumn get word => _word ??= _constructWord();
  GeneratedTextColumn _constructWord() {
    return GeneratedTextColumn('word', $tableName, false,
        minTextLength: 1, $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, word];
  @override
  $WordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'words';
  @override
  final String actualTableName = 'words';
  @override
  VerificationContext validateIntegrity(WordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.word.present) {
      context.handle(
          _wordMeta, word.isAcceptableValue(d.word.value, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Word.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.word.present) {
      map['word'] = Variable<String, StringType>(d.word.value);
    }
    return map;
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(_db, alias);
  }
}

class Example extends DataClass implements Insertable<Example> {
  final int id;
  final String sentence;
  Example({this.id, @required this.sentence});
  factory Example.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Example(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      sentence: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sentence']),
    );
  }
  factory Example.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Example(
      id: serializer.fromJson<int>(json['id']),
      sentence: serializer.fromJson<String>(json['sentence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sentence': serializer.toJson<String>(sentence),
    };
  }

  @override
  ExamplesCompanion createCompanion(bool nullToAbsent) {
    return ExamplesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      sentence: sentence == null && nullToAbsent
          ? const Value.absent()
          : Value(sentence),
    );
  }

  Example copyWith({int id, String sentence}) => Example(
        id: id ?? this.id,
        sentence: sentence ?? this.sentence,
      );
  @override
  String toString() {
    return (StringBuffer('Example(')
          ..write('id: $id, ')
          ..write('sentence: $sentence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, sentence.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Example &&
          other.id == this.id &&
          other.sentence == this.sentence);
}

class ExamplesCompanion extends UpdateCompanion<Example> {
  final Value<int> id;
  final Value<String> sentence;
  const ExamplesCompanion({
    this.id = const Value.absent(),
    this.sentence = const Value.absent(),
  });
  ExamplesCompanion.insert({
    this.id = const Value.absent(),
    @required String sentence,
  }) : sentence = Value(sentence);
  ExamplesCompanion copyWith({Value<int> id, Value<String> sentence}) {
    return ExamplesCompanion(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
    );
  }
}

class $ExamplesTable extends Examples with TableInfo<$ExamplesTable, Example> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExamplesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _sentenceMeta = const VerificationMeta('sentence');
  GeneratedTextColumn _sentence;
  @override
  GeneratedTextColumn get sentence => _sentence ??= _constructSentence();
  GeneratedTextColumn _constructSentence() {
    return GeneratedTextColumn('sentence', $tableName, false,
        minTextLength: 1, $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, sentence];
  @override
  $ExamplesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'examples';
  @override
  final String actualTableName = 'examples';
  @override
  VerificationContext validateIntegrity(ExamplesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.sentence.present) {
      context.handle(_sentenceMeta,
          sentence.isAcceptableValue(d.sentence.value, _sentenceMeta));
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Example map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Example.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExamplesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.sentence.present) {
      map['sentence'] = Variable<String, StringType>(d.sentence.value);
    }
    return map;
  }

  @override
  $ExamplesTable createAlias(String alias) {
    return $ExamplesTable(_db, alias);
  }
}

class Syllable extends DataClass implements Insertable<Syllable> {
  final int id;
  final String syllable;
  Syllable({this.id, @required this.syllable});
  factory Syllable.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Syllable(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      syllable: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}syllable']),
    );
  }
  factory Syllable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Syllable(
      id: serializer.fromJson<int>(json['id']),
      syllable: serializer.fromJson<String>(json['syllable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syllable': serializer.toJson<String>(syllable),
    };
  }

  @override
  SyllablesCompanion createCompanion(bool nullToAbsent) {
    return SyllablesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      syllable: syllable == null && nullToAbsent
          ? const Value.absent()
          : Value(syllable),
    );
  }

  Syllable copyWith({int id, String syllable}) => Syllable(
        id: id ?? this.id,
        syllable: syllable ?? this.syllable,
      );
  @override
  String toString() {
    return (StringBuffer('Syllable(')
          ..write('id: $id, ')
          ..write('syllable: $syllable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, syllable.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Syllable &&
          other.id == this.id &&
          other.syllable == this.syllable);
}

class SyllablesCompanion extends UpdateCompanion<Syllable> {
  final Value<int> id;
  final Value<String> syllable;
  const SyllablesCompanion({
    this.id = const Value.absent(),
    this.syllable = const Value.absent(),
  });
  SyllablesCompanion.insert({
    this.id = const Value.absent(),
    @required String syllable,
  }) : syllable = Value(syllable);
  SyllablesCompanion copyWith({Value<int> id, Value<String> syllable}) {
    return SyllablesCompanion(
      id: id ?? this.id,
      syllable: syllable ?? this.syllable,
    );
  }
}

class $SyllablesTable extends Syllables
    with TableInfo<$SyllablesTable, Syllable> {
  final GeneratedDatabase _db;
  final String _alias;
  $SyllablesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _syllableMeta = const VerificationMeta('syllable');
  GeneratedTextColumn _syllable;
  @override
  GeneratedTextColumn get syllable => _syllable ??= _constructSyllable();
  GeneratedTextColumn _constructSyllable() {
    return GeneratedTextColumn('syllable', $tableName, false,
        minTextLength: 1, $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, syllable];
  @override
  $SyllablesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'syllables';
  @override
  final String actualTableName = 'syllables';
  @override
  VerificationContext validateIntegrity(SyllablesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.syllable.present) {
      context.handle(_syllableMeta,
          syllable.isAcceptableValue(d.syllable.value, _syllableMeta));
    } else if (isInserting) {
      context.missing(_syllableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Syllable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Syllable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SyllablesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.syllable.present) {
      map['syllable'] = Variable<String, StringType>(d.syllable.value);
    }
    return map;
  }

  @override
  $SyllablesTable createAlias(String alias) {
    return $SyllablesTable(_db, alias);
  }
}

class ThesaurusListData extends DataClass
    implements Insertable<ThesaurusListData> {
  final int senseId;
  final int wordId;
  final bool isAntonym;
  ThesaurusListData(
      {@required this.senseId,
      @required this.wordId,
      @required this.isAntonym});
  factory ThesaurusListData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ThesaurusListData(
      senseId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sense_id']),
      wordId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}word_id']),
      isAntonym: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_antonym']),
    );
  }
  factory ThesaurusListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ThesaurusListData(
      senseId: serializer.fromJson<int>(json['senseId']),
      wordId: serializer.fromJson<int>(json['wordId']),
      isAntonym: serializer.fromJson<bool>(json['isAntonym']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'senseId': serializer.toJson<int>(senseId),
      'wordId': serializer.toJson<int>(wordId),
      'isAntonym': serializer.toJson<bool>(isAntonym),
    };
  }

  @override
  ThesaurusListCompanion createCompanion(bool nullToAbsent) {
    return ThesaurusListCompanion(
      senseId: senseId == null && nullToAbsent
          ? const Value.absent()
          : Value(senseId),
      wordId:
          wordId == null && nullToAbsent ? const Value.absent() : Value(wordId),
      isAntonym: isAntonym == null && nullToAbsent
          ? const Value.absent()
          : Value(isAntonym),
    );
  }

  ThesaurusListData copyWith({int senseId, int wordId, bool isAntonym}) =>
      ThesaurusListData(
        senseId: senseId ?? this.senseId,
        wordId: wordId ?? this.wordId,
        isAntonym: isAntonym ?? this.isAntonym,
      );
  @override
  String toString() {
    return (StringBuffer('ThesaurusListData(')
          ..write('senseId: $senseId, ')
          ..write('wordId: $wordId, ')
          ..write('isAntonym: $isAntonym')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(senseId.hashCode, $mrjc(wordId.hashCode, isAntonym.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ThesaurusListData &&
          other.senseId == this.senseId &&
          other.wordId == this.wordId &&
          other.isAntonym == this.isAntonym);
}

class ThesaurusListCompanion extends UpdateCompanion<ThesaurusListData> {
  final Value<int> senseId;
  final Value<int> wordId;
  final Value<bool> isAntonym;
  const ThesaurusListCompanion({
    this.senseId = const Value.absent(),
    this.wordId = const Value.absent(),
    this.isAntonym = const Value.absent(),
  });
  ThesaurusListCompanion.insert({
    @required int senseId,
    @required int wordId,
    this.isAntonym = const Value.absent(),
  })  : senseId = Value(senseId),
        wordId = Value(wordId);
  ThesaurusListCompanion copyWith(
      {Value<int> senseId, Value<int> wordId, Value<bool> isAntonym}) {
    return ThesaurusListCompanion(
      senseId: senseId ?? this.senseId,
      wordId: wordId ?? this.wordId,
      isAntonym: isAntonym ?? this.isAntonym,
    );
  }
}

class $ThesaurusListTable extends ThesaurusList
    with TableInfo<$ThesaurusListTable, ThesaurusListData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ThesaurusListTable(this._db, [this._alias]);
  final VerificationMeta _senseIdMeta = const VerificationMeta('senseId');
  GeneratedIntColumn _senseId;
  @override
  GeneratedIntColumn get senseId => _senseId ??= _constructSenseId();
  GeneratedIntColumn _constructSenseId() {
    return GeneratedIntColumn('sense_id', $tableName, false,
        $customConstraints: 'REFERENCES senses(id)');
  }

  final VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  GeneratedIntColumn _wordId;
  @override
  GeneratedIntColumn get wordId => _wordId ??= _constructWordId();
  GeneratedIntColumn _constructWordId() {
    return GeneratedIntColumn('word_id', $tableName, false,
        $customConstraints: 'REFERENCES words(id)');
  }

  final VerificationMeta _isAntonymMeta = const VerificationMeta('isAntonym');
  GeneratedBoolColumn _isAntonym;
  @override
  GeneratedBoolColumn get isAntonym => _isAntonym ??= _constructIsAntonym();
  GeneratedBoolColumn _constructIsAntonym() {
    return GeneratedBoolColumn('is_antonym', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [senseId, wordId, isAntonym];
  @override
  $ThesaurusListTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'thesaurus_list';
  @override
  final String actualTableName = 'thesaurus_list';
  @override
  VerificationContext validateIntegrity(ThesaurusListCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.senseId.present) {
      context.handle(_senseIdMeta,
          senseId.isAcceptableValue(d.senseId.value, _senseIdMeta));
    } else if (isInserting) {
      context.missing(_senseIdMeta);
    }
    if (d.wordId.present) {
      context.handle(
          _wordIdMeta, wordId.isAcceptableValue(d.wordId.value, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (d.isAntonym.present) {
      context.handle(_isAntonymMeta,
          isAntonym.isAcceptableValue(d.isAntonym.value, _isAntonymMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {senseId, wordId, isAntonym};
  @override
  ThesaurusListData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ThesaurusListData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ThesaurusListCompanion d) {
    final map = <String, Variable>{};
    if (d.senseId.present) {
      map['sense_id'] = Variable<int, IntType>(d.senseId.value);
    }
    if (d.wordId.present) {
      map['word_id'] = Variable<int, IntType>(d.wordId.value);
    }
    if (d.isAntonym.present) {
      map['is_antonym'] = Variable<bool, BoolType>(d.isAntonym.value);
    }
    return map;
  }

  @override
  $ThesaurusListTable createAlias(String alias) {
    return $ThesaurusListTable(_db, alias);
  }
}

class ExampleListData extends DataClass implements Insertable<ExampleListData> {
  final int senseId;
  final int exampleId;
  ExampleListData({@required this.senseId, @required this.exampleId});
  factory ExampleListData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ExampleListData(
      senseId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sense_id']),
      exampleId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}example_id']),
    );
  }
  factory ExampleListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExampleListData(
      senseId: serializer.fromJson<int>(json['senseId']),
      exampleId: serializer.fromJson<int>(json['exampleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'senseId': serializer.toJson<int>(senseId),
      'exampleId': serializer.toJson<int>(exampleId),
    };
  }

  @override
  ExampleListCompanion createCompanion(bool nullToAbsent) {
    return ExampleListCompanion(
      senseId: senseId == null && nullToAbsent
          ? const Value.absent()
          : Value(senseId),
      exampleId: exampleId == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleId),
    );
  }

  ExampleListData copyWith({int senseId, int exampleId}) => ExampleListData(
        senseId: senseId ?? this.senseId,
        exampleId: exampleId ?? this.exampleId,
      );
  @override
  String toString() {
    return (StringBuffer('ExampleListData(')
          ..write('senseId: $senseId, ')
          ..write('exampleId: $exampleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(senseId.hashCode, exampleId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ExampleListData &&
          other.senseId == this.senseId &&
          other.exampleId == this.exampleId);
}

class ExampleListCompanion extends UpdateCompanion<ExampleListData> {
  final Value<int> senseId;
  final Value<int> exampleId;
  const ExampleListCompanion({
    this.senseId = const Value.absent(),
    this.exampleId = const Value.absent(),
  });
  ExampleListCompanion.insert({
    @required int senseId,
    @required int exampleId,
  })  : senseId = Value(senseId),
        exampleId = Value(exampleId);
  ExampleListCompanion copyWith({Value<int> senseId, Value<int> exampleId}) {
    return ExampleListCompanion(
      senseId: senseId ?? this.senseId,
      exampleId: exampleId ?? this.exampleId,
    );
  }
}

class $ExampleListTable extends ExampleList
    with TableInfo<$ExampleListTable, ExampleListData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExampleListTable(this._db, [this._alias]);
  final VerificationMeta _senseIdMeta = const VerificationMeta('senseId');
  GeneratedIntColumn _senseId;
  @override
  GeneratedIntColumn get senseId => _senseId ??= _constructSenseId();
  GeneratedIntColumn _constructSenseId() {
    return GeneratedIntColumn('sense_id', $tableName, false,
        $customConstraints: 'REFERENCES senses(id)');
  }

  final VerificationMeta _exampleIdMeta = const VerificationMeta('exampleId');
  GeneratedIntColumn _exampleId;
  @override
  GeneratedIntColumn get exampleId => _exampleId ??= _constructExampleId();
  GeneratedIntColumn _constructExampleId() {
    return GeneratedIntColumn('example_id', $tableName, false,
        $customConstraints: 'REFERENCES examples(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [senseId, exampleId];
  @override
  $ExampleListTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'example_list';
  @override
  final String actualTableName = 'example_list';
  @override
  VerificationContext validateIntegrity(ExampleListCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.senseId.present) {
      context.handle(_senseIdMeta,
          senseId.isAcceptableValue(d.senseId.value, _senseIdMeta));
    } else if (isInserting) {
      context.missing(_senseIdMeta);
    }
    if (d.exampleId.present) {
      context.handle(_exampleIdMeta,
          exampleId.isAcceptableValue(d.exampleId.value, _exampleIdMeta));
    } else if (isInserting) {
      context.missing(_exampleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {senseId, exampleId};
  @override
  ExampleListData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExampleListData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExampleListCompanion d) {
    final map = <String, Variable>{};
    if (d.senseId.present) {
      map['sense_id'] = Variable<int, IntType>(d.senseId.value);
    }
    if (d.exampleId.present) {
      map['example_id'] = Variable<int, IntType>(d.exampleId.value);
    }
    return map;
  }

  @override
  $ExampleListTable createAlias(String alias) {
    return $ExampleListTable(_db, alias);
  }
}

class SyllableListData extends DataClass
    implements Insertable<SyllableListData> {
  final int entryId;
  final int syllableId;
  SyllableListData({@required this.entryId, @required this.syllableId});
  factory SyllableListData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return SyllableListData(
      entryId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}entry_id']),
      syllableId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}syllable_id']),
    );
  }
  factory SyllableListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SyllableListData(
      entryId: serializer.fromJson<int>(json['entryId']),
      syllableId: serializer.fromJson<int>(json['syllableId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<int>(entryId),
      'syllableId': serializer.toJson<int>(syllableId),
    };
  }

  @override
  SyllableListCompanion createCompanion(bool nullToAbsent) {
    return SyllableListCompanion(
      entryId: entryId == null && nullToAbsent
          ? const Value.absent()
          : Value(entryId),
      syllableId: syllableId == null && nullToAbsent
          ? const Value.absent()
          : Value(syllableId),
    );
  }

  SyllableListData copyWith({int entryId, int syllableId}) => SyllableListData(
        entryId: entryId ?? this.entryId,
        syllableId: syllableId ?? this.syllableId,
      );
  @override
  String toString() {
    return (StringBuffer('SyllableListData(')
          ..write('entryId: $entryId, ')
          ..write('syllableId: $syllableId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(entryId.hashCode, syllableId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SyllableListData &&
          other.entryId == this.entryId &&
          other.syllableId == this.syllableId);
}

class SyllableListCompanion extends UpdateCompanion<SyllableListData> {
  final Value<int> entryId;
  final Value<int> syllableId;
  const SyllableListCompanion({
    this.entryId = const Value.absent(),
    this.syllableId = const Value.absent(),
  });
  SyllableListCompanion.insert({
    @required int entryId,
    @required int syllableId,
  })  : entryId = Value(entryId),
        syllableId = Value(syllableId);
  SyllableListCompanion copyWith({Value<int> entryId, Value<int> syllableId}) {
    return SyllableListCompanion(
      entryId: entryId ?? this.entryId,
      syllableId: syllableId ?? this.syllableId,
    );
  }
}

class $SyllableListTable extends SyllableList
    with TableInfo<$SyllableListTable, SyllableListData> {
  final GeneratedDatabase _db;
  final String _alias;
  $SyllableListTable(this._db, [this._alias]);
  final VerificationMeta _entryIdMeta = const VerificationMeta('entryId');
  GeneratedIntColumn _entryId;
  @override
  GeneratedIntColumn get entryId => _entryId ??= _constructEntryId();
  GeneratedIntColumn _constructEntryId() {
    return GeneratedIntColumn('entry_id', $tableName, false,
        $customConstraints: 'REFERENCES entries(id)');
  }

  final VerificationMeta _syllableIdMeta = const VerificationMeta('syllableId');
  GeneratedIntColumn _syllableId;
  @override
  GeneratedIntColumn get syllableId => _syllableId ??= _constructSyllableId();
  GeneratedIntColumn _constructSyllableId() {
    return GeneratedIntColumn('syllable_id', $tableName, false,
        $customConstraints: 'REFERENCES syllables(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [entryId, syllableId];
  @override
  $SyllableListTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'syllable_list';
  @override
  final String actualTableName = 'syllable_list';
  @override
  VerificationContext validateIntegrity(SyllableListCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (d.syllableId.present) {
      context.handle(_syllableIdMeta,
          syllableId.isAcceptableValue(d.syllableId.value, _syllableIdMeta));
    } else if (isInserting) {
      context.missing(_syllableIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  SyllableListData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SyllableListData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SyllableListCompanion d) {
    final map = <String, Variable>{};
    if (d.entryId.present) {
      map['entry_id'] = Variable<int, IntType>(d.entryId.value);
    }
    if (d.syllableId.present) {
      map['syllable_id'] = Variable<int, IntType>(d.syllableId.value);
    }
    return map;
  }

  @override
  $SyllableListTable createAlias(String alias) {
    return $SyllableListTable(_db, alias);
  }
}

class EntryQuizCard extends DataClass implements Insertable<EntryQuizCard> {
  final int cardId;
  final int entryId;
  EntryQuizCard({@required this.cardId, @required this.entryId});
  factory EntryQuizCard.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return EntryQuizCard(
      cardId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}card_id']),
      entryId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}entry_id']),
    );
  }
  factory EntryQuizCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EntryQuizCard(
      cardId: serializer.fromJson<int>(json['cardId']),
      entryId: serializer.fromJson<int>(json['entryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<int>(cardId),
      'entryId': serializer.toJson<int>(entryId),
    };
  }

  @override
  EntryQuizCardsCompanion createCompanion(bool nullToAbsent) {
    return EntryQuizCardsCompanion(
      cardId:
          cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      entryId: entryId == null && nullToAbsent
          ? const Value.absent()
          : Value(entryId),
    );
  }

  EntryQuizCard copyWith({int cardId, int entryId}) => EntryQuizCard(
        cardId: cardId ?? this.cardId,
        entryId: entryId ?? this.entryId,
      );
  @override
  String toString() {
    return (StringBuffer('EntryQuizCard(')
          ..write('cardId: $cardId, ')
          ..write('entryId: $entryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(cardId.hashCode, entryId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EntryQuizCard &&
          other.cardId == this.cardId &&
          other.entryId == this.entryId);
}

class EntryQuizCardsCompanion extends UpdateCompanion<EntryQuizCard> {
  final Value<int> cardId;
  final Value<int> entryId;
  const EntryQuizCardsCompanion({
    this.cardId = const Value.absent(),
    this.entryId = const Value.absent(),
  });
  EntryQuizCardsCompanion.insert({
    @required int cardId,
    @required int entryId,
  })  : cardId = Value(cardId),
        entryId = Value(entryId);
  EntryQuizCardsCompanion copyWith({Value<int> cardId, Value<int> entryId}) {
    return EntryQuizCardsCompanion(
      cardId: cardId ?? this.cardId,
      entryId: entryId ?? this.entryId,
    );
  }
}

class $EntryQuizCardsTable extends EntryQuizCards
    with TableInfo<$EntryQuizCardsTable, EntryQuizCard> {
  final GeneratedDatabase _db;
  final String _alias;
  $EntryQuizCardsTable(this._db, [this._alias]);
  final VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  GeneratedIntColumn _cardId;
  @override
  GeneratedIntColumn get cardId => _cardId ??= _constructCardId();
  GeneratedIntColumn _constructCardId() {
    return GeneratedIntColumn('card_id', $tableName, false,
        $customConstraints: 'REFERENCES cards(id)');
  }

  final VerificationMeta _entryIdMeta = const VerificationMeta('entryId');
  GeneratedIntColumn _entryId;
  @override
  GeneratedIntColumn get entryId => _entryId ??= _constructEntryId();
  GeneratedIntColumn _constructEntryId() {
    return GeneratedIntColumn('entry_id', $tableName, false,
        $customConstraints: 'REFERENCES entries(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [cardId, entryId];
  @override
  $EntryQuizCardsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'entry_quiz_cards';
  @override
  final String actualTableName = 'entry_quiz_cards';
  @override
  VerificationContext validateIntegrity(EntryQuizCardsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.cardId.present) {
      context.handle(
          _cardIdMeta, cardId.isAcceptableValue(d.cardId.value, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cardId, entryId};
  @override
  EntryQuizCard map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EntryQuizCard.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EntryQuizCardsCompanion d) {
    final map = <String, Variable>{};
    if (d.cardId.present) {
      map['card_id'] = Variable<int, IntType>(d.cardId.value);
    }
    if (d.entryId.present) {
      map['entry_id'] = Variable<int, IntType>(d.entryId.value);
    }
    return map;
  }

  @override
  $EntryQuizCardsTable createAlias(String alias) {
    return $EntryQuizCardsTable(_db, alias);
  }
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final int frontId;
  final int backId;
  final int level;
  final bool isImportant;
  final DateTime dueOn;
  Card(
      {this.id,
      @required this.frontId,
      @required this.backId,
      this.level,
      this.isImportant,
      @required this.dueOn});
  factory Card.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Card(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      frontId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}front_id']),
      backId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}back_id']),
      level: intType.mapFromDatabaseResponse(data['${effectivePrefix}level']),
      isImportant: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_important']),
      dueOn: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_on']),
    );
  }
  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      frontId: serializer.fromJson<int>(json['frontId']),
      backId: serializer.fromJson<int>(json['backId']),
      level: serializer.fromJson<int>(json['level']),
      isImportant: serializer.fromJson<bool>(json['isImportant']),
      dueOn: serializer.fromJson<DateTime>(json['dueOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'frontId': serializer.toJson<int>(frontId),
      'backId': serializer.toJson<int>(backId),
      'level': serializer.toJson<int>(level),
      'isImportant': serializer.toJson<bool>(isImportant),
      'dueOn': serializer.toJson<DateTime>(dueOn),
    };
  }

  @override
  CardsCompanion createCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      frontId: frontId == null && nullToAbsent
          ? const Value.absent()
          : Value(frontId),
      backId:
          backId == null && nullToAbsent ? const Value.absent() : Value(backId),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      isImportant: isImportant == null && nullToAbsent
          ? const Value.absent()
          : Value(isImportant),
      dueOn:
          dueOn == null && nullToAbsent ? const Value.absent() : Value(dueOn),
    );
  }

  Card copyWith(
          {int id,
          int frontId,
          int backId,
          int level,
          bool isImportant,
          DateTime dueOn}) =>
      Card(
        id: id ?? this.id,
        frontId: frontId ?? this.frontId,
        backId: backId ?? this.backId,
        level: level ?? this.level,
        isImportant: isImportant ?? this.isImportant,
        dueOn: dueOn ?? this.dueOn,
      );
  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('frontId: $frontId, ')
          ..write('backId: $backId, ')
          ..write('level: $level, ')
          ..write('isImportant: $isImportant, ')
          ..write('dueOn: $dueOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          frontId.hashCode,
          $mrjc(
              backId.hashCode,
              $mrjc(level.hashCode,
                  $mrjc(isImportant.hashCode, dueOn.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.frontId == this.frontId &&
          other.backId == this.backId &&
          other.level == this.level &&
          other.isImportant == this.isImportant &&
          other.dueOn == this.dueOn);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<int> frontId;
  final Value<int> backId;
  final Value<int> level;
  final Value<bool> isImportant;
  final Value<DateTime> dueOn;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.frontId = const Value.absent(),
    this.backId = const Value.absent(),
    this.level = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.dueOn = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    @required int frontId,
    @required int backId,
    this.level = const Value.absent(),
    this.isImportant = const Value.absent(),
    @required DateTime dueOn,
  })  : frontId = Value(frontId),
        backId = Value(backId),
        dueOn = Value(dueOn);
  CardsCompanion copyWith(
      {Value<int> id,
      Value<int> frontId,
      Value<int> backId,
      Value<int> level,
      Value<bool> isImportant,
      Value<DateTime> dueOn}) {
    return CardsCompanion(
      id: id ?? this.id,
      frontId: frontId ?? this.frontId,
      backId: backId ?? this.backId,
      level: level ?? this.level,
      isImportant: isImportant ?? this.isImportant,
      dueOn: dueOn ?? this.dueOn,
    );
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  final GeneratedDatabase _db;
  final String _alias;
  $CardsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _frontIdMeta = const VerificationMeta('frontId');
  GeneratedIntColumn _frontId;
  @override
  GeneratedIntColumn get frontId => _frontId ??= _constructFrontId();
  GeneratedIntColumn _constructFrontId() {
    return GeneratedIntColumn('front_id', $tableName, false,
        $customConstraints: 'REFERENCES card_info(id)');
  }

  final VerificationMeta _backIdMeta = const VerificationMeta('backId');
  GeneratedIntColumn _backId;
  @override
  GeneratedIntColumn get backId => _backId ??= _constructBackId();
  GeneratedIntColumn _constructBackId() {
    return GeneratedIntColumn('back_id', $tableName, false,
        $customConstraints: 'REFERENCES card_info(id)');
  }

  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedIntColumn _level;
  @override
  GeneratedIntColumn get level => _level ??= _constructLevel();
  GeneratedIntColumn _constructLevel() {
    return GeneratedIntColumn('level', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _isImportantMeta =
      const VerificationMeta('isImportant');
  GeneratedBoolColumn _isImportant;
  @override
  GeneratedBoolColumn get isImportant =>
      _isImportant ??= _constructIsImportant();
  GeneratedBoolColumn _constructIsImportant() {
    return GeneratedBoolColumn('is_important', $tableName, true,
        defaultValue: Constant(false));
  }

  final VerificationMeta _dueOnMeta = const VerificationMeta('dueOn');
  GeneratedDateTimeColumn _dueOn;
  @override
  GeneratedDateTimeColumn get dueOn => _dueOn ??= _constructDueOn();
  GeneratedDateTimeColumn _constructDueOn() {
    return GeneratedDateTimeColumn(
      'due_on',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, frontId, backId, level, isImportant, dueOn];
  @override
  $CardsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cards';
  @override
  final String actualTableName = 'cards';
  @override
  VerificationContext validateIntegrity(CardsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.frontId.present) {
      context.handle(_frontIdMeta,
          frontId.isAcceptableValue(d.frontId.value, _frontIdMeta));
    } else if (isInserting) {
      context.missing(_frontIdMeta);
    }
    if (d.backId.present) {
      context.handle(
          _backIdMeta, backId.isAcceptableValue(d.backId.value, _backIdMeta));
    } else if (isInserting) {
      context.missing(_backIdMeta);
    }
    if (d.level.present) {
      context.handle(
          _levelMeta, level.isAcceptableValue(d.level.value, _levelMeta));
    }
    if (d.isImportant.present) {
      context.handle(_isImportantMeta,
          isImportant.isAcceptableValue(d.isImportant.value, _isImportantMeta));
    }
    if (d.dueOn.present) {
      context.handle(
          _dueOnMeta, dueOn.isAcceptableValue(d.dueOn.value, _dueOnMeta));
    } else if (isInserting) {
      context.missing(_dueOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Card.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CardsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.frontId.present) {
      map['front_id'] = Variable<int, IntType>(d.frontId.value);
    }
    if (d.backId.present) {
      map['back_id'] = Variable<int, IntType>(d.backId.value);
    }
    if (d.level.present) {
      map['level'] = Variable<int, IntType>(d.level.value);
    }
    if (d.isImportant.present) {
      map['is_important'] = Variable<bool, BoolType>(d.isImportant.value);
    }
    if (d.dueOn.present) {
      map['due_on'] = Variable<DateTime, DateTimeType>(d.dueOn.value);
    }
    return map;
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(_db, alias);
  }
}

class CardInfoData extends DataClass implements Insertable<CardInfoData> {
  final int id;
  final int entryId;
  final int senseId;
  final int attributeType;
  CardInfoData(
      {this.id,
      @required this.entryId,
      @required this.senseId,
      @required this.attributeType});
  factory CardInfoData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return CardInfoData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      entryId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}entry_id']),
      senseId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sense_id']),
      attributeType: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}attribute_type']),
    );
  }
  factory CardInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CardInfoData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      senseId: serializer.fromJson<int>(json['senseId']),
      attributeType: serializer.fromJson<int>(json['attributeType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'senseId': serializer.toJson<int>(senseId),
      'attributeType': serializer.toJson<int>(attributeType),
    };
  }

  @override
  CardInfoCompanion createCompanion(bool nullToAbsent) {
    return CardInfoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      entryId: entryId == null && nullToAbsent
          ? const Value.absent()
          : Value(entryId),
      senseId: senseId == null && nullToAbsent
          ? const Value.absent()
          : Value(senseId),
      attributeType: attributeType == null && nullToAbsent
          ? const Value.absent()
          : Value(attributeType),
    );
  }

  CardInfoData copyWith(
          {int id, int entryId, int senseId, int attributeType}) =>
      CardInfoData(
        id: id ?? this.id,
        entryId: entryId ?? this.entryId,
        senseId: senseId ?? this.senseId,
        attributeType: attributeType ?? this.attributeType,
      );
  @override
  String toString() {
    return (StringBuffer('CardInfoData(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('senseId: $senseId, ')
          ..write('attributeType: $attributeType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          entryId.hashCode, $mrjc(senseId.hashCode, attributeType.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CardInfoData &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.senseId == this.senseId &&
          other.attributeType == this.attributeType);
}

class CardInfoCompanion extends UpdateCompanion<CardInfoData> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<int> senseId;
  final Value<int> attributeType;
  const CardInfoCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.senseId = const Value.absent(),
    this.attributeType = const Value.absent(),
  });
  CardInfoCompanion.insert({
    this.id = const Value.absent(),
    @required int entryId,
    @required int senseId,
    @required int attributeType,
  })  : entryId = Value(entryId),
        senseId = Value(senseId),
        attributeType = Value(attributeType);
  CardInfoCompanion copyWith(
      {Value<int> id,
      Value<int> entryId,
      Value<int> senseId,
      Value<int> attributeType}) {
    return CardInfoCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      senseId: senseId ?? this.senseId,
      attributeType: attributeType ?? this.attributeType,
    );
  }
}

class $CardInfoTable extends CardInfo
    with TableInfo<$CardInfoTable, CardInfoData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CardInfoTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _entryIdMeta = const VerificationMeta('entryId');
  GeneratedIntColumn _entryId;
  @override
  GeneratedIntColumn get entryId => _entryId ??= _constructEntryId();
  GeneratedIntColumn _constructEntryId() {
    return GeneratedIntColumn('entry_id', $tableName, false,
        $customConstraints: 'REFERENCES entries(id)');
  }

  final VerificationMeta _senseIdMeta = const VerificationMeta('senseId');
  GeneratedIntColumn _senseId;
  @override
  GeneratedIntColumn get senseId => _senseId ??= _constructSenseId();
  GeneratedIntColumn _constructSenseId() {
    return GeneratedIntColumn('sense_id', $tableName, false,
        $customConstraints: 'REFERENCES senses(id)');
  }

  final VerificationMeta _attributeTypeMeta =
      const VerificationMeta('attributeType');
  GeneratedIntColumn _attributeType;
  @override
  GeneratedIntColumn get attributeType =>
      _attributeType ??= _constructAttributeType();
  GeneratedIntColumn _constructAttributeType() {
    return GeneratedIntColumn(
      'attribute_type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, entryId, senseId, attributeType];
  @override
  $CardInfoTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'card_info';
  @override
  final String actualTableName = 'card_info';
  @override
  VerificationContext validateIntegrity(CardInfoCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (d.senseId.present) {
      context.handle(_senseIdMeta,
          senseId.isAcceptableValue(d.senseId.value, _senseIdMeta));
    } else if (isInserting) {
      context.missing(_senseIdMeta);
    }
    if (d.attributeType.present) {
      context.handle(
          _attributeTypeMeta,
          attributeType.isAcceptableValue(
              d.attributeType.value, _attributeTypeMeta));
    } else if (isInserting) {
      context.missing(_attributeTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardInfoData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CardInfoData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CardInfoCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.entryId.present) {
      map['entry_id'] = Variable<int, IntType>(d.entryId.value);
    }
    if (d.senseId.present) {
      map['sense_id'] = Variable<int, IntType>(d.senseId.value);
    }
    if (d.attributeType.present) {
      map['attribute_type'] = Variable<int, IntType>(d.attributeType.value);
    }
    return map;
  }

  @override
  $CardInfoTable createAlias(String alias) {
    return $CardInfoTable(_db, alias);
  }
}

class UsageInfoData extends DataClass implements Insertable<UsageInfoData> {
  final DateTime date;
  final int wordsSearched;
  final int wordsSaved;
  final int cardsQuizzed;
  final int wordsEdited;
  final int wordsDeleted;
  final int cardsCorrect;
  final int cardsWrong;
  UsageInfoData(
      {@required this.date,
      this.wordsSearched,
      this.wordsSaved,
      this.cardsQuizzed,
      this.wordsEdited,
      this.wordsDeleted,
      this.cardsCorrect,
      this.cardsWrong});
  factory UsageInfoData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return UsageInfoData(
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      wordsSearched: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}words_searched']),
      wordsSaved: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}words_saved']),
      cardsQuizzed: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}cards_quizzed']),
      wordsEdited: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}words_edited']),
      wordsDeleted: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}words_deleted']),
      cardsCorrect: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}cards_correct']),
      cardsWrong: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}cards_wrong']),
    );
  }
  factory UsageInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UsageInfoData(
      date: serializer.fromJson<DateTime>(json['date']),
      wordsSearched: serializer.fromJson<int>(json['wordsSearched']),
      wordsSaved: serializer.fromJson<int>(json['wordsSaved']),
      cardsQuizzed: serializer.fromJson<int>(json['cardsQuizzed']),
      wordsEdited: serializer.fromJson<int>(json['wordsEdited']),
      wordsDeleted: serializer.fromJson<int>(json['wordsDeleted']),
      cardsCorrect: serializer.fromJson<int>(json['cardsCorrect']),
      cardsWrong: serializer.fromJson<int>(json['cardsWrong']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'wordsSearched': serializer.toJson<int>(wordsSearched),
      'wordsSaved': serializer.toJson<int>(wordsSaved),
      'cardsQuizzed': serializer.toJson<int>(cardsQuizzed),
      'wordsEdited': serializer.toJson<int>(wordsEdited),
      'wordsDeleted': serializer.toJson<int>(wordsDeleted),
      'cardsCorrect': serializer.toJson<int>(cardsCorrect),
      'cardsWrong': serializer.toJson<int>(cardsWrong),
    };
  }

  @override
  UsageInfoCompanion createCompanion(bool nullToAbsent) {
    return UsageInfoCompanion(
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      wordsSearched: wordsSearched == null && nullToAbsent
          ? const Value.absent()
          : Value(wordsSearched),
      wordsSaved: wordsSaved == null && nullToAbsent
          ? const Value.absent()
          : Value(wordsSaved),
      cardsQuizzed: cardsQuizzed == null && nullToAbsent
          ? const Value.absent()
          : Value(cardsQuizzed),
      wordsEdited: wordsEdited == null && nullToAbsent
          ? const Value.absent()
          : Value(wordsEdited),
      wordsDeleted: wordsDeleted == null && nullToAbsent
          ? const Value.absent()
          : Value(wordsDeleted),
      cardsCorrect: cardsCorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(cardsCorrect),
      cardsWrong: cardsWrong == null && nullToAbsent
          ? const Value.absent()
          : Value(cardsWrong),
    );
  }

  UsageInfoData copyWith(
          {DateTime date,
          int wordsSearched,
          int wordsSaved,
          int cardsQuizzed,
          int wordsEdited,
          int wordsDeleted,
          int cardsCorrect,
          int cardsWrong}) =>
      UsageInfoData(
        date: date ?? this.date,
        wordsSearched: wordsSearched ?? this.wordsSearched,
        wordsSaved: wordsSaved ?? this.wordsSaved,
        cardsQuizzed: cardsQuizzed ?? this.cardsQuizzed,
        wordsEdited: wordsEdited ?? this.wordsEdited,
        wordsDeleted: wordsDeleted ?? this.wordsDeleted,
        cardsCorrect: cardsCorrect ?? this.cardsCorrect,
        cardsWrong: cardsWrong ?? this.cardsWrong,
      );
  @override
  String toString() {
    return (StringBuffer('UsageInfoData(')
          ..write('date: $date, ')
          ..write('wordsSearched: $wordsSearched, ')
          ..write('wordsSaved: $wordsSaved, ')
          ..write('cardsQuizzed: $cardsQuizzed, ')
          ..write('wordsEdited: $wordsEdited, ')
          ..write('wordsDeleted: $wordsDeleted, ')
          ..write('cardsCorrect: $cardsCorrect, ')
          ..write('cardsWrong: $cardsWrong')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      date.hashCode,
      $mrjc(
          wordsSearched.hashCode,
          $mrjc(
              wordsSaved.hashCode,
              $mrjc(
                  cardsQuizzed.hashCode,
                  $mrjc(
                      wordsEdited.hashCode,
                      $mrjc(
                          wordsDeleted.hashCode,
                          $mrjc(cardsCorrect.hashCode,
                              cardsWrong.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UsageInfoData &&
          other.date == this.date &&
          other.wordsSearched == this.wordsSearched &&
          other.wordsSaved == this.wordsSaved &&
          other.cardsQuizzed == this.cardsQuizzed &&
          other.wordsEdited == this.wordsEdited &&
          other.wordsDeleted == this.wordsDeleted &&
          other.cardsCorrect == this.cardsCorrect &&
          other.cardsWrong == this.cardsWrong);
}

class UsageInfoCompanion extends UpdateCompanion<UsageInfoData> {
  final Value<DateTime> date;
  final Value<int> wordsSearched;
  final Value<int> wordsSaved;
  final Value<int> cardsQuizzed;
  final Value<int> wordsEdited;
  final Value<int> wordsDeleted;
  final Value<int> cardsCorrect;
  final Value<int> cardsWrong;
  const UsageInfoCompanion({
    this.date = const Value.absent(),
    this.wordsSearched = const Value.absent(),
    this.wordsSaved = const Value.absent(),
    this.cardsQuizzed = const Value.absent(),
    this.wordsEdited = const Value.absent(),
    this.wordsDeleted = const Value.absent(),
    this.cardsCorrect = const Value.absent(),
    this.cardsWrong = const Value.absent(),
  });
  UsageInfoCompanion.insert({
    @required DateTime date,
    this.wordsSearched = const Value.absent(),
    this.wordsSaved = const Value.absent(),
    this.cardsQuizzed = const Value.absent(),
    this.wordsEdited = const Value.absent(),
    this.wordsDeleted = const Value.absent(),
    this.cardsCorrect = const Value.absent(),
    this.cardsWrong = const Value.absent(),
  }) : date = Value(date);
  UsageInfoCompanion copyWith(
      {Value<DateTime> date,
      Value<int> wordsSearched,
      Value<int> wordsSaved,
      Value<int> cardsQuizzed,
      Value<int> wordsEdited,
      Value<int> wordsDeleted,
      Value<int> cardsCorrect,
      Value<int> cardsWrong}) {
    return UsageInfoCompanion(
      date: date ?? this.date,
      wordsSearched: wordsSearched ?? this.wordsSearched,
      wordsSaved: wordsSaved ?? this.wordsSaved,
      cardsQuizzed: cardsQuizzed ?? this.cardsQuizzed,
      wordsEdited: wordsEdited ?? this.wordsEdited,
      wordsDeleted: wordsDeleted ?? this.wordsDeleted,
      cardsCorrect: cardsCorrect ?? this.cardsCorrect,
      cardsWrong: cardsWrong ?? this.cardsWrong,
    );
  }
}

class $UsageInfoTable extends UsageInfo
    with TableInfo<$UsageInfoTable, UsageInfoData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsageInfoTable(this._db, [this._alias]);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _wordsSearchedMeta =
      const VerificationMeta('wordsSearched');
  GeneratedIntColumn _wordsSearched;
  @override
  GeneratedIntColumn get wordsSearched =>
      _wordsSearched ??= _constructWordsSearched();
  GeneratedIntColumn _constructWordsSearched() {
    return GeneratedIntColumn('words_searched', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _wordsSavedMeta = const VerificationMeta('wordsSaved');
  GeneratedIntColumn _wordsSaved;
  @override
  GeneratedIntColumn get wordsSaved => _wordsSaved ??= _constructWordsSaved();
  GeneratedIntColumn _constructWordsSaved() {
    return GeneratedIntColumn('words_saved', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _cardsQuizzedMeta =
      const VerificationMeta('cardsQuizzed');
  GeneratedIntColumn _cardsQuizzed;
  @override
  GeneratedIntColumn get cardsQuizzed =>
      _cardsQuizzed ??= _constructCardsQuizzed();
  GeneratedIntColumn _constructCardsQuizzed() {
    return GeneratedIntColumn('cards_quizzed', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _wordsEditedMeta =
      const VerificationMeta('wordsEdited');
  GeneratedIntColumn _wordsEdited;
  @override
  GeneratedIntColumn get wordsEdited =>
      _wordsEdited ??= _constructWordsEdited();
  GeneratedIntColumn _constructWordsEdited() {
    return GeneratedIntColumn('words_edited', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _wordsDeletedMeta =
      const VerificationMeta('wordsDeleted');
  GeneratedIntColumn _wordsDeleted;
  @override
  GeneratedIntColumn get wordsDeleted =>
      _wordsDeleted ??= _constructWordsDeleted();
  GeneratedIntColumn _constructWordsDeleted() {
    return GeneratedIntColumn('words_deleted', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _cardsCorrectMeta =
      const VerificationMeta('cardsCorrect');
  GeneratedIntColumn _cardsCorrect;
  @override
  GeneratedIntColumn get cardsCorrect =>
      _cardsCorrect ??= _constructCardsCorrect();
  GeneratedIntColumn _constructCardsCorrect() {
    return GeneratedIntColumn('cards_correct', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _cardsWrongMeta = const VerificationMeta('cardsWrong');
  GeneratedIntColumn _cardsWrong;
  @override
  GeneratedIntColumn get cardsWrong => _cardsWrong ??= _constructCardsWrong();
  GeneratedIntColumn _constructCardsWrong() {
    return GeneratedIntColumn('cards_wrong', $tableName, true,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [
        date,
        wordsSearched,
        wordsSaved,
        cardsQuizzed,
        wordsEdited,
        wordsDeleted,
        cardsCorrect,
        cardsWrong
      ];
  @override
  $UsageInfoTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'usage_info';
  @override
  final String actualTableName = 'usage_info';
  @override
  VerificationContext validateIntegrity(UsageInfoCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (d.wordsSearched.present) {
      context.handle(
          _wordsSearchedMeta,
          wordsSearched.isAcceptableValue(
              d.wordsSearched.value, _wordsSearchedMeta));
    }
    if (d.wordsSaved.present) {
      context.handle(_wordsSavedMeta,
          wordsSaved.isAcceptableValue(d.wordsSaved.value, _wordsSavedMeta));
    }
    if (d.cardsQuizzed.present) {
      context.handle(
          _cardsQuizzedMeta,
          cardsQuizzed.isAcceptableValue(
              d.cardsQuizzed.value, _cardsQuizzedMeta));
    }
    if (d.wordsEdited.present) {
      context.handle(_wordsEditedMeta,
          wordsEdited.isAcceptableValue(d.wordsEdited.value, _wordsEditedMeta));
    }
    if (d.wordsDeleted.present) {
      context.handle(
          _wordsDeletedMeta,
          wordsDeleted.isAcceptableValue(
              d.wordsDeleted.value, _wordsDeletedMeta));
    }
    if (d.cardsCorrect.present) {
      context.handle(
          _cardsCorrectMeta,
          cardsCorrect.isAcceptableValue(
              d.cardsCorrect.value, _cardsCorrectMeta));
    }
    if (d.cardsWrong.present) {
      context.handle(_cardsWrongMeta,
          cardsWrong.isAcceptableValue(d.cardsWrong.value, _cardsWrongMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  UsageInfoData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UsageInfoData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsageInfoCompanion d) {
    final map = <String, Variable>{};
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.wordsSearched.present) {
      map['words_searched'] = Variable<int, IntType>(d.wordsSearched.value);
    }
    if (d.wordsSaved.present) {
      map['words_saved'] = Variable<int, IntType>(d.wordsSaved.value);
    }
    if (d.cardsQuizzed.present) {
      map['cards_quizzed'] = Variable<int, IntType>(d.cardsQuizzed.value);
    }
    if (d.wordsEdited.present) {
      map['words_edited'] = Variable<int, IntType>(d.wordsEdited.value);
    }
    if (d.wordsDeleted.present) {
      map['words_deleted'] = Variable<int, IntType>(d.wordsDeleted.value);
    }
    if (d.cardsCorrect.present) {
      map['cards_correct'] = Variable<int, IntType>(d.cardsCorrect.value);
    }
    if (d.cardsWrong.present) {
      map['cards_wrong'] = Variable<int, IntType>(d.cardsWrong.value);
    }
    return map;
  }

  @override
  $UsageInfoTable createAlias(String alias) {
    return $UsageInfoTable(_db, alias);
  }
}

abstract class _$CardDatabase extends GeneratedDatabase {
  _$CardDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EntriesTable _entries;
  $EntriesTable get entries => _entries ??= $EntriesTable(this);
  $SensesTable _senses;
  $SensesTable get senses => _senses ??= $SensesTable(this);
  $WordsTable _words;
  $WordsTable get words => _words ??= $WordsTable(this);
  $ExamplesTable _examples;
  $ExamplesTable get examples => _examples ??= $ExamplesTable(this);
  $SyllablesTable _syllables;
  $SyllablesTable get syllables => _syllables ??= $SyllablesTable(this);
  $ThesaurusListTable _thesaurusList;
  $ThesaurusListTable get thesaurusList =>
      _thesaurusList ??= $ThesaurusListTable(this);
  $ExampleListTable _exampleList;
  $ExampleListTable get exampleList => _exampleList ??= $ExampleListTable(this);
  $SyllableListTable _syllableList;
  $SyllableListTable get syllableList =>
      _syllableList ??= $SyllableListTable(this);
  $EntryQuizCardsTable _entryQuizCards;
  $EntryQuizCardsTable get entryQuizCards =>
      _entryQuizCards ??= $EntryQuizCardsTable(this);
  $CardsTable _cards;
  $CardsTable get cards => _cards ??= $CardsTable(this);
  $CardInfoTable _cardInfo;
  $CardInfoTable get cardInfo => _cardInfo ??= $CardInfoTable(this);
  $UsageInfoTable _usageInfo;
  $UsageInfoTable get usageInfo => _usageInfo ??= $UsageInfoTable(this);
  WordDao _wordDao;
  WordDao get wordDao => _wordDao ??= WordDao(this as CardDatabase);
  QuizCardDao _quizCardDao;
  QuizCardDao get quizCardDao =>
      _quizCardDao ??= QuizCardDao(this as CardDatabase);
  StatisticsDao _statisticsDao;
  StatisticsDao get statisticsDao =>
      _statisticsDao ??= StatisticsDao(this as CardDatabase);
  FetchWordDao _fetchWordDao;
  FetchWordDao get fetchWordDao =>
      _fetchWordDao ??= FetchWordDao(this as CardDatabase);
  QuizCardCreateDao _quizCardCreateDao;
  QuizCardCreateDao get quizCardCreateDao =>
      _quizCardCreateDao ??= QuizCardCreateDao(this as CardDatabase);
  QuizDao _quizDao;
  QuizDao get quizDao => _quizDao ??= QuizDao(this as CardDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        entries,
        senses,
        words,
        examples,
        syllables,
        thesaurusList,
        exampleList,
        syllableList,
        entryQuizCards,
        cards,
        cardInfo,
        usageInfo
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$QuizCardDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
  $ExamplesTable get examples => db.examples;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
  $CardsTable get cards => db.cards;
  $CardInfoTable get cardInfo => db.cardInfo;
  $EntryQuizCardsTable get entryQuizCards => db.entryQuizCards;
  $UsageInfoTable get usageInfo => db.usageInfo;
}
mixin _$StatisticsDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
  $ExamplesTable get examples => db.examples;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
  $CardsTable get cards => db.cards;
  $CardInfoTable get cardInfo => db.cardInfo;
  $EntryQuizCardsTable get entryQuizCards => db.entryQuizCards;
  $UsageInfoTable get usageInfo => db.usageInfo;
  GetPartOfSpeechStatsResult _rowToGetPartOfSpeechStatsResult(QueryRow row) {
    return GetPartOfSpeechStatsResult(
      partOfSpeech: row.readInt('part_of_speech'),
      count: row.readInt('COUNT(*)'),
    );
  }

  Selectable<GetPartOfSpeechStatsResult> _getPartOfSpeechStatsQuery() {
    return customSelectQuery(
        'SELECT part_of_speech, COUNT(*) FROM senses GROUP BY part_of_speech',
        variables: [],
        readsFrom: {senses}).map(_rowToGetPartOfSpeechStatsResult);
  }

  Future<List<GetPartOfSpeechStatsResult>> _getPartOfSpeechStats() {
    return _getPartOfSpeechStatsQuery().get();
  }

  Stream<List<GetPartOfSpeechStatsResult>> _watchGetPartOfSpeechStats() {
    return _getPartOfSpeechStatsQuery().watch();
  }

  Selectable<int> _getUntouchedCardCountQuery() {
    return customSelectQuery('SELECT COUNT(*) FROM cards WHERE level <= 0',
        variables: [],
        readsFrom: {cards}).map((QueryRow row) => row.readInt('COUNT(*)'));
  }

  Future<List<int>> _getUntouchedCardCount() {
    return _getUntouchedCardCountQuery().get();
  }

  Stream<List<int>> _watchGetUntouchedCardCount() {
    return _getUntouchedCardCountQuery().watch();
  }

  Selectable<int> _getLearningCardCountQuery() {
    return customSelectQuery(
        'SELECT COUNT(*) FROM cards WHERE level BETWEEN 1 AND 10',
        variables: [],
        readsFrom: {cards}).map((QueryRow row) => row.readInt('COUNT(*)'));
  }

  Future<List<int>> _getLearningCardCount() {
    return _getLearningCardCountQuery().get();
  }

  Stream<List<int>> _watchGetLearningCardCount() {
    return _getLearningCardCountQuery().watch();
  }

  Selectable<int> _getFamiliarCardCountQuery() {
    return customSelectQuery(
        'SELECT COUNT(*) FROM cards WHERE level BETWEEN 11 AND 24',
        variables: [],
        readsFrom: {cards}).map((QueryRow row) => row.readInt('COUNT(*)'));
  }

  Future<List<int>> _getFamiliarCardCount() {
    return _getFamiliarCardCountQuery().get();
  }

  Stream<List<int>> _watchGetFamiliarCardCount() {
    return _getFamiliarCardCountQuery().watch();
  }

  Selectable<int> _getMasteredCardCountQuery() {
    return customSelectQuery('SELECT COUNT(*) FROM cards WHERE level > 24',
        variables: [],
        readsFrom: {cards}).map((QueryRow row) => row.readInt('COUNT(*)'));
  }

  Future<List<int>> _getMasteredCardCount() {
    return _getMasteredCardCountQuery().get();
  }

  Stream<List<int>> _watchGetMasteredCardCount() {
    return _getMasteredCardCountQuery().watch();
  }
}

class GetPartOfSpeechStatsResult {
  final int partOfSpeech;
  final int count;
  GetPartOfSpeechStatsResult({
    this.partOfSpeech,
    this.count,
  });
}

mixin _$FetchWordDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
}
mixin _$WordDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
  $ExamplesTable get examples => db.examples;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
  $UsageInfoTable get usageInfo => db.usageInfo;
}
mixin _$QuizCardCreateDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
  $ExamplesTable get examples => db.examples;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
  $CardsTable get cards => db.cards;
  $CardInfoTable get cardInfo => db.cardInfo;
  $EntryQuizCardsTable get entryQuizCards => db.entryQuizCards;
  $UsageInfoTable get usageInfo => db.usageInfo;
}
mixin _$QuizDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
  $ExamplesTable get examples => db.examples;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
  $CardsTable get cards => db.cards;
  $CardInfoTable get cardInfo => db.cardInfo;
  $EntryQuizCardsTable get entryQuizCards => db.entryQuizCards;
  $UsageInfoTable get usageInfo => db.usageInfo;
}
