// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Entrie extends DataClass implements Insertable<Entrie> {
  final int id;
  final DateTime addedOn;
  final String pronunciation;
  final int syllableId;
  final int wordId;
  Entrie(
      {@required this.id,
      @required this.addedOn,
      @required this.pronunciation,
      @required this.syllableId,
      @required this.wordId});
  factory Entrie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Entrie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      addedOn: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}added_on']),
      pronunciation: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pronunciation']),
      syllableId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}syllable_id']),
      wordId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}word_id']),
    );
  }
  factory Entrie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Entrie(
      id: serializer.fromJson<int>(json['id']),
      addedOn: serializer.fromJson<DateTime>(json['addedOn']),
      pronunciation: serializer.fromJson<String>(json['pronunciation']),
      syllableId: serializer.fromJson<int>(json['syllableId']),
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
      'syllableId': serializer.toJson<int>(syllableId),
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
      syllableId: syllableId == null && nullToAbsent
          ? const Value.absent()
          : Value(syllableId),
      wordId:
          wordId == null && nullToAbsent ? const Value.absent() : Value(wordId),
    );
  }

  Entrie copyWith(
          {int id,
          DateTime addedOn,
          String pronunciation,
          int syllableId,
          int wordId}) =>
      Entrie(
        id: id ?? this.id,
        addedOn: addedOn ?? this.addedOn,
        pronunciation: pronunciation ?? this.pronunciation,
        syllableId: syllableId ?? this.syllableId,
        wordId: wordId ?? this.wordId,
      );
  @override
  String toString() {
    return (StringBuffer('Entrie(')
          ..write('id: $id, ')
          ..write('addedOn: $addedOn, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('syllableId: $syllableId, ')
          ..write('wordId: $wordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          addedOn.hashCode,
          $mrjc(pronunciation.hashCode,
              $mrjc(syllableId.hashCode, wordId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Entrie &&
          other.id == this.id &&
          other.addedOn == this.addedOn &&
          other.pronunciation == this.pronunciation &&
          other.syllableId == this.syllableId &&
          other.wordId == this.wordId);
}

class EntriesCompanion extends UpdateCompanion<Entrie> {
  final Value<int> id;
  final Value<DateTime> addedOn;
  final Value<String> pronunciation;
  final Value<int> syllableId;
  final Value<int> wordId;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.addedOn = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.syllableId = const Value.absent(),
    this.wordId = const Value.absent(),
  });
  EntriesCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime addedOn,
    @required String pronunciation,
    @required int syllableId,
    @required int wordId,
  })  : addedOn = Value(addedOn),
        pronunciation = Value(pronunciation),
        syllableId = Value(syllableId),
        wordId = Value(wordId);
  EntriesCompanion copyWith(
      {Value<int> id,
      Value<DateTime> addedOn,
      Value<String> pronunciation,
      Value<int> syllableId,
      Value<int> wordId}) {
    return EntriesCompanion(
      id: id ?? this.id,
      addedOn: addedOn ?? this.addedOn,
      pronunciation: pronunciation ?? this.pronunciation,
      syllableId: syllableId ?? this.syllableId,
      wordId: wordId ?? this.wordId,
    );
  }
}

class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entrie> {
  final GeneratedDatabase _db;
  final String _alias;
  $EntriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
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

  final VerificationMeta _syllableIdMeta = const VerificationMeta('syllableId');
  GeneratedIntColumn _syllableId;
  @override
  GeneratedIntColumn get syllableId => _syllableId ??= _constructSyllableId();
  GeneratedIntColumn _constructSyllableId() {
    return GeneratedIntColumn('syllable_id', $tableName, false,
        $customConstraints: 'REFERENCES Syllable(id)');
  }

  final VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  GeneratedIntColumn _wordId;
  @override
  GeneratedIntColumn get wordId => _wordId ??= _constructWordId();
  GeneratedIntColumn _constructWordId() {
    return GeneratedIntColumn('word_id', $tableName, false,
        $customConstraints: 'REFERENCES Word(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, addedOn, pronunciation, syllableId, wordId];
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
    if (d.syllableId.present) {
      context.handle(_syllableIdMeta,
          syllableId.isAcceptableValue(d.syllableId.value, _syllableIdMeta));
    } else if (syllableId.isRequired && isInserting) {
      context.missing(_syllableIdMeta);
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
  Entrie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Entrie.fromData(data, _db, prefix: effectivePrefix);
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
    if (d.syllableId.present) {
      map['syllable_id'] = Variable<int, IntType>(d.syllableId.value);
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
      {@required this.id,
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
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _entryIdMeta = const VerificationMeta('entryId');
  GeneratedIntColumn _entryId;
  @override
  GeneratedIntColumn get entryId => _entryId ??= _constructEntryId();
  GeneratedIntColumn _constructEntryId() {
    return GeneratedIntColumn('entry_id', $tableName, false,
        $customConstraints: 'REFERENCES Entry(id)');
  }

  final VerificationMeta _partOfSpeechMeta =
      const VerificationMeta('partOfSpeech');
  GeneratedIntColumn _partOfSpeech;
  @override
  GeneratedIntColumn get partOfSpeech =>
      _partOfSpeech ??= _constructPartOfSpeech();
  GeneratedIntColumn _constructPartOfSpeech() {
    return GeneratedIntColumn('part_of_speech', $tableName, false,
        $customConstraints: 'REFERENCES PartsOfSpeech(id)');
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
  Word({@required this.id, @required this.word});
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
    return GeneratedIntColumn('id', $tableName, false,
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
  Example({@required this.id, @required this.sentence});
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
    return GeneratedIntColumn('id', $tableName, false,
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

class PartsOfSpeechData extends DataClass
    implements Insertable<PartsOfSpeechData> {
  final int id;
  final String partOfSpeech;
  PartsOfSpeechData({@required this.id, @required this.partOfSpeech});
  factory PartsOfSpeechData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return PartsOfSpeechData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      partOfSpeech: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}part_of_speech']),
    );
  }
  factory PartsOfSpeechData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return PartsOfSpeechData(
      id: serializer.fromJson<int>(json['id']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
    };
  }

  @override
  PartsOfSpeechCompanion createCompanion(bool nullToAbsent) {
    return PartsOfSpeechCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
    );
  }

  PartsOfSpeechData copyWith({int id, String partOfSpeech}) =>
      PartsOfSpeechData(
        id: id ?? this.id,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      );
  @override
  String toString() {
    return (StringBuffer('PartsOfSpeechData(')
          ..write('id: $id, ')
          ..write('partOfSpeech: $partOfSpeech')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, partOfSpeech.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PartsOfSpeechData &&
          other.id == this.id &&
          other.partOfSpeech == this.partOfSpeech);
}

class PartsOfSpeechCompanion extends UpdateCompanion<PartsOfSpeechData> {
  final Value<int> id;
  final Value<String> partOfSpeech;
  const PartsOfSpeechCompanion({
    this.id = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
  });
  PartsOfSpeechCompanion.insert({
    this.id = const Value.absent(),
    @required String partOfSpeech,
  }) : partOfSpeech = Value(partOfSpeech);
  PartsOfSpeechCompanion copyWith({Value<int> id, Value<String> partOfSpeech}) {
    return PartsOfSpeechCompanion(
      id: id ?? this.id,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    );
  }
}

class $PartsOfSpeechTable extends PartsOfSpeech
    with TableInfo<$PartsOfSpeechTable, PartsOfSpeechData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PartsOfSpeechTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _partOfSpeechMeta =
      const VerificationMeta('partOfSpeech');
  GeneratedTextColumn _partOfSpeech;
  @override
  GeneratedTextColumn get partOfSpeech =>
      _partOfSpeech ??= _constructPartOfSpeech();
  GeneratedTextColumn _constructPartOfSpeech() {
    return GeneratedTextColumn('part_of_speech', $tableName, false,
        minTextLength: 1, $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, partOfSpeech];
  @override
  $PartsOfSpeechTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'parts_of_speech';
  @override
  final String actualTableName = 'parts_of_speech';
  @override
  VerificationContext validateIntegrity(PartsOfSpeechCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.partOfSpeech.present) {
      context.handle(
          _partOfSpeechMeta,
          partOfSpeech.isAcceptableValue(
              d.partOfSpeech.value, _partOfSpeechMeta));
    } else if (partOfSpeech.isRequired && isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartsOfSpeechData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PartsOfSpeechData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PartsOfSpeechCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.partOfSpeech.present) {
      map['part_of_speech'] =
          Variable<String, StringType>(d.partOfSpeech.value);
    }
    return map;
  }

  @override
  $PartsOfSpeechTable createAlias(String alias) {
    return $PartsOfSpeechTable(_db, alias);
  }
}

class Syllable extends DataClass implements Insertable<Syllable> {
  final int id;
  final String syllable;
  Syllable({@required this.id, @required this.syllable});
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
    return GeneratedIntColumn('id', $tableName, false,
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
        $customConstraints: 'REFERENCES Sense(id)');
  }

  final VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  GeneratedIntColumn _wordId;
  @override
  GeneratedIntColumn get wordId => _wordId ??= _constructWordId();
  GeneratedIntColumn _constructWordId() {
    return GeneratedIntColumn('word_id', $tableName, false,
        $customConstraints: 'REFERENCES Word(id)');
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
        $customConstraints: 'REFERENCES Sense(id)');
  }

  final VerificationMeta _exampleIdMeta = const VerificationMeta('exampleId');
  GeneratedIntColumn _exampleId;
  @override
  GeneratedIntColumn get exampleId => _exampleId ??= _constructExampleId();
  GeneratedIntColumn _constructExampleId() {
    return GeneratedIntColumn('example_id', $tableName, false,
        $customConstraints: 'REFERENCES Example(id)');
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
        $customConstraints: 'REFERENCES Entry(id)');
  }

  final VerificationMeta _syllableIdMeta = const VerificationMeta('syllableId');
  GeneratedIntColumn _syllableId;
  @override
  GeneratedIntColumn get syllableId => _syllableId ??= _constructSyllableId();
  GeneratedIntColumn _constructSyllableId() {
    return GeneratedIntColumn('syllable_id', $tableName, false,
        $customConstraints: 'REFERENCES Syllable(id)');
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

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final int questionId;
  final int answerId;
  final int level;
  final bool isImportant;
  final DateTime dueOn;
  Card(
      {@required this.id,
      @required this.questionId,
      @required this.answerId,
      @required this.level,
      @required this.isImportant,
      @required this.dueOn});
  factory Card.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Card(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      questionId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}question_id']),
      answerId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}answer_id']),
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
      questionId: serializer.fromJson<int>(json['questionId']),
      answerId: serializer.fromJson<int>(json['answerId']),
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
      'questionId': serializer.toJson<int>(questionId),
      'answerId': serializer.toJson<int>(answerId),
      'level': serializer.toJson<int>(level),
      'isImportant': serializer.toJson<bool>(isImportant),
      'dueOn': serializer.toJson<DateTime>(dueOn),
    };
  }

  @override
  CardsCompanion createCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      questionId: questionId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionId),
      answerId: answerId == null && nullToAbsent
          ? const Value.absent()
          : Value(answerId),
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
          int questionId,
          int answerId,
          int level,
          bool isImportant,
          DateTime dueOn}) =>
      Card(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        answerId: answerId ?? this.answerId,
        level: level ?? this.level,
        isImportant: isImportant ?? this.isImportant,
        dueOn: dueOn ?? this.dueOn,
      );
  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('answerId: $answerId, ')
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
          questionId.hashCode,
          $mrjc(
              answerId.hashCode,
              $mrjc(level.hashCode,
                  $mrjc(isImportant.hashCode, dueOn.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.answerId == this.answerId &&
          other.level == this.level &&
          other.isImportant == this.isImportant &&
          other.dueOn == this.dueOn);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<int> questionId;
  final Value<int> answerId;
  final Value<int> level;
  final Value<bool> isImportant;
  final Value<DateTime> dueOn;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.answerId = const Value.absent(),
    this.level = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.dueOn = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    @required int questionId,
    @required int answerId,
    @required int level,
    this.isImportant = const Value.absent(),
    @required DateTime dueOn,
  })  : questionId = Value(questionId),
        answerId = Value(answerId),
        level = Value(level),
        dueOn = Value(dueOn);
  CardsCompanion copyWith(
      {Value<int> id,
      Value<int> questionId,
      Value<int> answerId,
      Value<int> level,
      Value<bool> isImportant,
      Value<DateTime> dueOn}) {
    return CardsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      answerId: answerId ?? this.answerId,
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
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _questionIdMeta = const VerificationMeta('questionId');
  GeneratedIntColumn _questionId;
  @override
  GeneratedIntColumn get questionId => _questionId ??= _constructQuestionId();
  GeneratedIntColumn _constructQuestionId() {
    return GeneratedIntColumn('question_id', $tableName, false,
        $customConstraints: 'REFERENCES CardInfo(id)');
  }

  final VerificationMeta _answerIdMeta = const VerificationMeta('answerId');
  GeneratedIntColumn _answerId;
  @override
  GeneratedIntColumn get answerId => _answerId ??= _constructAnswerId();
  GeneratedIntColumn _constructAnswerId() {
    return GeneratedIntColumn('answer_id', $tableName, false,
        $customConstraints: 'REFERENCES CardInfo(id)');
  }

  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedIntColumn _level;
  @override
  GeneratedIntColumn get level => _level ??= _constructLevel();
  GeneratedIntColumn _constructLevel() {
    return GeneratedIntColumn(
      'level',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isImportantMeta =
      const VerificationMeta('isImportant');
  GeneratedBoolColumn _isImportant;
  @override
  GeneratedBoolColumn get isImportant =>
      _isImportant ??= _constructIsImportant();
  GeneratedBoolColumn _constructIsImportant() {
    return GeneratedBoolColumn('is_important', $tableName, false,
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
      [id, questionId, answerId, level, isImportant, dueOn];
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
    if (d.questionId.present) {
      context.handle(_questionIdMeta,
          questionId.isAcceptableValue(d.questionId.value, _questionIdMeta));
    } else if (questionId.isRequired && isInserting) {
      context.missing(_questionIdMeta);
    }
    if (d.answerId.present) {
      context.handle(_answerIdMeta,
          answerId.isAcceptableValue(d.answerId.value, _answerIdMeta));
    } else if (answerId.isRequired && isInserting) {
      context.missing(_answerIdMeta);
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
    if (d.questionId.present) {
      map['question_id'] = Variable<int, IntType>(d.questionId.value);
    }
    if (d.answerId.present) {
      map['answer_id'] = Variable<int, IntType>(d.answerId.value);
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
  final int attributeId;
  CardInfoData(
      {@required this.id,
      @required this.entryId,
      @required this.senseId,
      @required this.attributeId});
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
      attributeId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}attribute_id']),
    );
  }
  factory CardInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CardInfoData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      senseId: serializer.fromJson<int>(json['senseId']),
      attributeId: serializer.fromJson<int>(json['attributeId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'senseId': serializer.toJson<int>(senseId),
      'attributeId': serializer.toJson<int>(attributeId),
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
      attributeId: attributeId == null && nullToAbsent
          ? const Value.absent()
          : Value(attributeId),
    );
  }

  CardInfoData copyWith({int id, int entryId, int senseId, int attributeId}) =>
      CardInfoData(
        id: id ?? this.id,
        entryId: entryId ?? this.entryId,
        senseId: senseId ?? this.senseId,
        attributeId: attributeId ?? this.attributeId,
      );
  @override
  String toString() {
    return (StringBuffer('CardInfoData(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('senseId: $senseId, ')
          ..write('attributeId: $attributeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(entryId.hashCode, $mrjc(senseId.hashCode, attributeId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CardInfoData &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.senseId == this.senseId &&
          other.attributeId == this.attributeId);
}

class CardInfoCompanion extends UpdateCompanion<CardInfoData> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<int> senseId;
  final Value<int> attributeId;
  const CardInfoCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.senseId = const Value.absent(),
    this.attributeId = const Value.absent(),
  });
  CardInfoCompanion.insert({
    this.id = const Value.absent(),
    @required int entryId,
    @required int senseId,
    @required int attributeId,
  })  : entryId = Value(entryId),
        senseId = Value(senseId),
        attributeId = Value(attributeId);
  CardInfoCompanion copyWith(
      {Value<int> id,
      Value<int> entryId,
      Value<int> senseId,
      Value<int> attributeId}) {
    return CardInfoCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      senseId: senseId ?? this.senseId,
      attributeId: attributeId ?? this.attributeId,
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
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _entryIdMeta = const VerificationMeta('entryId');
  GeneratedIntColumn _entryId;
  @override
  GeneratedIntColumn get entryId => _entryId ??= _constructEntryId();
  GeneratedIntColumn _constructEntryId() {
    return GeneratedIntColumn('entry_id', $tableName, false,
        $customConstraints: 'REFERENCES Entry(id)');
  }

  final VerificationMeta _senseIdMeta = const VerificationMeta('senseId');
  GeneratedIntColumn _senseId;
  @override
  GeneratedIntColumn get senseId => _senseId ??= _constructSenseId();
  GeneratedIntColumn _constructSenseId() {
    return GeneratedIntColumn('sense_id', $tableName, false,
        $customConstraints: 'REFERENCES Sense(id)');
  }

  final VerificationMeta _attributeIdMeta =
      const VerificationMeta('attributeId');
  GeneratedIntColumn _attributeId;
  @override
  GeneratedIntColumn get attributeId =>
      _attributeId ??= _constructAttributeId();
  GeneratedIntColumn _constructAttributeId() {
    return GeneratedIntColumn('attribute_id', $tableName, false,
        $customConstraints: 'REFERENCES Attribute(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, entryId, senseId, attributeId];
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
    if (d.attributeId.present) {
      context.handle(_attributeIdMeta,
          attributeId.isAcceptableValue(d.attributeId.value, _attributeIdMeta));
    } else if (attributeId.isRequired && isInserting) {
      context.missing(_attributeIdMeta);
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
    if (d.attributeId.present) {
      map['attribute_id'] = Variable<int, IntType>(d.attributeId.value);
    }
    return map;
  }

  @override
  $CardInfoTable createAlias(String alias) {
    return $CardInfoTable(_db, alias);
  }
}

class AttributeData extends DataClass implements Insertable<AttributeData> {
  final int id;
  final String attribute;
  AttributeData({@required this.id, @required this.attribute});
  factory AttributeData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AttributeData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      attribute: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}attribute']),
    );
  }
  factory AttributeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return AttributeData(
      id: serializer.fromJson<int>(json['id']),
      attribute: serializer.fromJson<String>(json['attribute']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'attribute': serializer.toJson<String>(attribute),
    };
  }

  @override
  AttributeCompanion createCompanion(bool nullToAbsent) {
    return AttributeCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      attribute: attribute == null && nullToAbsent
          ? const Value.absent()
          : Value(attribute),
    );
  }

  AttributeData copyWith({int id, String attribute}) => AttributeData(
        id: id ?? this.id,
        attribute: attribute ?? this.attribute,
      );
  @override
  String toString() {
    return (StringBuffer('AttributeData(')
          ..write('id: $id, ')
          ..write('attribute: $attribute')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, attribute.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AttributeData &&
          other.id == this.id &&
          other.attribute == this.attribute);
}

class AttributeCompanion extends UpdateCompanion<AttributeData> {
  final Value<int> id;
  final Value<String> attribute;
  const AttributeCompanion({
    this.id = const Value.absent(),
    this.attribute = const Value.absent(),
  });
  AttributeCompanion.insert({
    this.id = const Value.absent(),
    @required String attribute,
  }) : attribute = Value(attribute);
  AttributeCompanion copyWith({Value<int> id, Value<String> attribute}) {
    return AttributeCompanion(
      id: id ?? this.id,
      attribute: attribute ?? this.attribute,
    );
  }
}

class $AttributeTable extends Attribute
    with TableInfo<$AttributeTable, AttributeData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AttributeTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _attributeMeta = const VerificationMeta('attribute');
  GeneratedTextColumn _attribute;
  @override
  GeneratedTextColumn get attribute => _attribute ??= _constructAttribute();
  GeneratedTextColumn _constructAttribute() {
    return GeneratedTextColumn('attribute', $tableName, false,
        minTextLength: 1, $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, attribute];
  @override
  $AttributeTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'attribute';
  @override
  final String actualTableName = 'attribute';
  @override
  VerificationContext validateIntegrity(AttributeCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.attribute.present) {
      context.handle(_attributeMeta,
          attribute.isAcceptableValue(d.attribute.value, _attributeMeta));
    } else if (attribute.isRequired && isInserting) {
      context.missing(_attributeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttributeData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AttributeData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AttributeCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.attribute.present) {
      map['attribute'] = Variable<String, StringType>(d.attribute.value);
    }
    return map;
  }

  @override
  $AttributeTable createAlias(String alias) {
    return $AttributeTable(_db, alias);
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
  $PartsOfSpeechTable _partsOfSpeech;
  $PartsOfSpeechTable get partsOfSpeech =>
      _partsOfSpeech ??= $PartsOfSpeechTable(this);
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
  $CardsTable _cards;
  $CardsTable get cards => _cards ??= $CardsTable(this);
  $CardInfoTable _cardInfo;
  $CardInfoTable get cardInfo => _cardInfo ??= $CardInfoTable(this);
  $AttributeTable _attribute;
  $AttributeTable get attribute => _attribute ??= $AttributeTable(this);
  @override
  List<TableInfo> get allTables => [
        entries,
        senses,
        words,
        examples,
        partsOfSpeech,
        syllables,
        thesaurusList,
        exampleList,
        syllableList,
        cards,
        cardInfo,
        attribute
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
  $PartsOfSpeechTable get partsOfSpeech => db.partsOfSpeech;
  $SyllablesTable get syllables => db.syllables;
  $ThesaurusListTable get thesaurusList => db.thesaurusList;
  $ExampleListTable get exampleList => db.exampleList;
  $SyllableListTable get syllableList => db.syllableList;
}
