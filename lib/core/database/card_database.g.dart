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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Entry(
      id: serializer.fromJson<int>(json['id']),
      addedOn: serializer.fromJson<DateTime>(json['addedOn']),
      pronunciation: serializer.fromJson<String>(json['pronunciation']),
      wordId: serializer.fromJson<int>(json['wordId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.addedOn.present) {
      context.handle(_addedOnMeta,
          addedOn.isAcceptableValue(d.addedOn.value, _addedOnMeta));
    } else if (addedOn.isRequired && isInserting) {
      context.missing(_addedOnMeta);
    }
    if (d.pronunciation.present) {
      context.handle(
          _pronunciationMeta,
          pronunciation.isAcceptableValue(
              d.pronunciation.value, _pronunciationMeta));
    } else if (pronunciation.isRequired && isInserting) {
      context.missing(_pronunciationMeta);
    }
    if (d.wordId.present) {
      context.handle(
          _wordIdMeta, wordId.isAcceptableValue(d.wordId.value, _wordIdMeta));
    } else if (wordId.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Sense(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      partOfSpeech: serializer.fromJson<int>(json['partOfSpeech']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (entryId.isRequired && isInserting) {
      context.missing(_entryIdMeta);
    }
    if (d.partOfSpeech.present) {
      context.handle(
          _partOfSpeechMeta,
          partOfSpeech.isAcceptableValue(
              d.partOfSpeech.value, _partOfSpeechMeta));
    } else if (partOfSpeech.isRequired && isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (d.definition.present) {
      context.handle(_definitionMeta,
          definition.isAcceptableValue(d.definition.value, _definitionMeta));
    } else if (definition.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Word(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.word.present) {
      context.handle(
          _wordMeta, word.isAcceptableValue(d.word.value, _wordMeta));
    } else if (word.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Example(
      id: serializer.fromJson<int>(json['id']),
      sentence: serializer.fromJson<String>(json['sentence']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.sentence.present) {
      context.handle(_sentenceMeta,
          sentence.isAcceptableValue(d.sentence.value, _sentenceMeta));
    } else if (sentence.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Syllable(
      id: serializer.fromJson<int>(json['id']),
      syllable: serializer.fromJson<String>(json['syllable']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.syllable.present) {
      context.handle(_syllableMeta,
          syllable.isAcceptableValue(d.syllable.value, _syllableMeta));
    } else if (syllable.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return ThesaurusListData(
      senseId: serializer.fromJson<int>(json['senseId']),
      wordId: serializer.fromJson<int>(json['wordId']),
      isAntonym: serializer.fromJson<bool>(json['isAntonym']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (senseId.isRequired && isInserting) {
      context.missing(_senseIdMeta);
    }
    if (d.wordId.present) {
      context.handle(
          _wordIdMeta, wordId.isAcceptableValue(d.wordId.value, _wordIdMeta));
    } else if (wordId.isRequired && isInserting) {
      context.missing(_wordIdMeta);
    }
    if (d.isAntonym.present) {
      context.handle(_isAntonymMeta,
          isAntonym.isAcceptableValue(d.isAntonym.value, _isAntonymMeta));
    } else if (isAntonym.isRequired && isInserting) {
      context.missing(_isAntonymMeta);
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return ExampleListData(
      senseId: serializer.fromJson<int>(json['senseId']),
      exampleId: serializer.fromJson<int>(json['exampleId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (senseId.isRequired && isInserting) {
      context.missing(_senseIdMeta);
    }
    if (d.exampleId.present) {
      context.handle(_exampleIdMeta,
          exampleId.isAcceptableValue(d.exampleId.value, _exampleIdMeta));
    } else if (exampleId.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return SyllableListData(
      entryId: serializer.fromJson<int>(json['entryId']),
      syllableId: serializer.fromJson<int>(json['syllableId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (entryId.isRequired && isInserting) {
      context.missing(_entryIdMeta);
    }
    if (d.syllableId.present) {
      context.handle(_syllableIdMeta,
          syllableId.isAcceptableValue(d.syllableId.value, _syllableIdMeta));
    } else if (syllableId.isRequired && isInserting) {
      context.missing(_syllableIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, syllableId};
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return EntryQuizCard(
      cardId: serializer.fromJson<int>(json['cardId']),
      entryId: serializer.fromJson<int>(json['entryId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (cardId.isRequired && isInserting) {
      context.missing(_cardIdMeta);
    }
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (entryId.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.frontId.present) {
      context.handle(_frontIdMeta,
          frontId.isAcceptableValue(d.frontId.value, _frontIdMeta));
    } else if (frontId.isRequired && isInserting) {
      context.missing(_frontIdMeta);
    }
    if (d.backId.present) {
      context.handle(
          _backIdMeta, backId.isAcceptableValue(d.backId.value, _backIdMeta));
    } else if (backId.isRequired && isInserting) {
      context.missing(_backIdMeta);
    }
    if (d.level.present) {
      context.handle(
          _levelMeta, level.isAcceptableValue(d.level.value, _levelMeta));
    } else if (level.isRequired && isInserting) {
      context.missing(_levelMeta);
    }
    if (d.isImportant.present) {
      context.handle(_isImportantMeta,
          isImportant.isAcceptableValue(d.isImportant.value, _isImportantMeta));
    } else if (isImportant.isRequired && isInserting) {
      context.missing(_isImportantMeta);
    }
    if (d.dueOn.present) {
      context.handle(
          _dueOnMeta, dueOn.isAcceptableValue(d.dueOn.value, _dueOnMeta));
    } else if (dueOn.isRequired && isInserting) {
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
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CardInfoData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      senseId: serializer.fromJson<int>(json['senseId']),
      attributeType: serializer.fromJson<int>(json['attributeType']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
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
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.entryId.present) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableValue(d.entryId.value, _entryIdMeta));
    } else if (entryId.isRequired && isInserting) {
      context.missing(_entryIdMeta);
    }
    if (d.senseId.present) {
      context.handle(_senseIdMeta,
          senseId.isAcceptableValue(d.senseId.value, _senseIdMeta));
    } else if (senseId.isRequired && isInserting) {
      context.missing(_senseIdMeta);
    }
    if (d.attributeType.present) {
      context.handle(
          _attributeTypeMeta,
          attributeType.isAcceptableValue(
              d.attributeType.value, _attributeTypeMeta));
    } else if (attributeType.isRequired && isInserting) {
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
  WordDao _wordDao;
  WordDao get wordDao => _wordDao ??= WordDao(this as CardDatabase);
  CardDao _cardDao;
  CardDao get cardDao => _cardDao ??= CardDao(this as CardDatabase);
  @override
  List<TableInfo> get allTables => [
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
        cardInfo
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$WordDaoMixin on DatabaseAccessor<CardDatabase> {
  $EntriesTable get entries => db.entries;
  $SensesTable get senses => db.senses;
  $WordsTable get words => db.words;
  $ExamplesTable get examples => db.examples;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
}
mixin _$CardDaoMixin on DatabaseAccessor<CardDatabase> {
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
}
