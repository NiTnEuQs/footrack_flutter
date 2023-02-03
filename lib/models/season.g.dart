// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'season.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, use_super_parameters

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class SeasonCollectionReference
    implements
        SeasonQuery,
        FirestoreCollectionReference<Season, SeasonQuerySnapshot> {
  factory SeasonCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$SeasonCollectionReference;

  static Season fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Season.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Season value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Season> get reference;

  @override
  SeasonDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<SeasonDocumentReference> add(Season value);
}

class _$SeasonCollectionReference extends _$SeasonQuery
    implements SeasonCollectionReference {
  factory _$SeasonCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$SeasonCollectionReference._(
      firestore.collection('seasons').withConverter(
            fromFirestore: SeasonCollectionReference.fromFirestore,
            toFirestore: SeasonCollectionReference.toFirestore,
          ),
    );
  }

  _$SeasonCollectionReference._(
    CollectionReference<Season> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Season> get reference =>
      super.reference as CollectionReference<Season>;

  @override
  SeasonDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return SeasonDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<SeasonDocumentReference> add(Season value) {
    return reference.add(value).then((ref) => SeasonDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$SeasonCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class SeasonDocumentReference
    extends FirestoreDocumentReference<Season, SeasonDocumentSnapshot> {
  factory SeasonDocumentReference(DocumentReference<Season> reference) =
      _$SeasonDocumentReference;

  DocumentReference<Season> get reference;

  /// A reference to the [SeasonCollectionReference] containing this document.
  SeasonCollectionReference get parent {
    return _$SeasonCollectionReference(reference.firestore);
  }

  late final PlayerCollectionReference players = _$PlayerCollectionReference(
    reference,
  );

  late final OpponentCollectionReference opponents =
      _$OpponentCollectionReference(
    reference,
  );

  late final MatchCollectionReference matchs = _$MatchCollectionReference(
    reference,
  );

  @override
  Stream<SeasonDocumentSnapshot> snapshots();

  @override
  Future<SeasonDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String name,
    FieldValue nameFieldValue,
    String? teamName,
    FieldValue teamNameFieldValue,
    DateTime? from,
    FieldValue fromFieldValue,
    DateTime? to,
    FieldValue toFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String name,
    FieldValue nameFieldValue,
    String? teamName,
    FieldValue teamNameFieldValue,
    DateTime? from,
    FieldValue fromFieldValue,
    DateTime? to,
    FieldValue toFieldValue,
  });
}

class _$SeasonDocumentReference
    extends FirestoreDocumentReference<Season, SeasonDocumentSnapshot>
    implements SeasonDocumentReference {
  _$SeasonDocumentReference(this.reference);

  @override
  final DocumentReference<Season> reference;

  /// A reference to the [SeasonCollectionReference] containing this document.
  SeasonCollectionReference get parent {
    return _$SeasonCollectionReference(reference.firestore);
  }

  late final PlayerCollectionReference players = _$PlayerCollectionReference(
    reference,
  );

  late final OpponentCollectionReference opponents =
      _$OpponentCollectionReference(
    reference,
  );

  late final MatchCollectionReference matchs = _$MatchCollectionReference(
    reference,
  );

  @override
  Stream<SeasonDocumentSnapshot> snapshots() {
    return reference.snapshots().map(SeasonDocumentSnapshot._);
  }

  @override
  Future<SeasonDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(SeasonDocumentSnapshot._);
  }

  @override
  Future<SeasonDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(SeasonDocumentSnapshot._);
  }

  Future<void> update({
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? teamName = _sentinel,
    FieldValue? teamNameFieldValue,
    Object? from = _sentinel,
    FieldValue? fromFieldValue,
    Object? to = _sentinel,
    FieldValue? toFieldValue,
  }) async {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      teamName == _sentinel || teamNameFieldValue == null,
      "Cannot specify both teamName and teamNameFieldValue",
    );
    assert(
      from == _sentinel || fromFieldValue == null,
      "Cannot specify both from and fromFieldValue",
    );
    assert(
      to == _sentinel || toFieldValue == null,
      "Cannot specify both to and toFieldValue",
    );
    final json = {
      if (name != _sentinel) 'name': name as String,
      if (nameFieldValue != null) 'name': nameFieldValue,
      if (teamName != _sentinel) 'teamName': teamName as String?,
      if (teamNameFieldValue != null) 'teamName': teamNameFieldValue,
      if (from != _sentinel) 'from': from as DateTime?,
      if (fromFieldValue != null) 'from': fromFieldValue,
      if (to != _sentinel) 'to': to as DateTime?,
      if (toFieldValue != null) 'to': toFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? teamName = _sentinel,
    FieldValue? teamNameFieldValue,
    Object? from = _sentinel,
    FieldValue? fromFieldValue,
    Object? to = _sentinel,
    FieldValue? toFieldValue,
  }) {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      teamName == _sentinel || teamNameFieldValue == null,
      "Cannot specify both teamName and teamNameFieldValue",
    );
    assert(
      from == _sentinel || fromFieldValue == null,
      "Cannot specify both from and fromFieldValue",
    );
    assert(
      to == _sentinel || toFieldValue == null,
      "Cannot specify both to and toFieldValue",
    );
    final json = {
      if (name != _sentinel) 'name': name as String,
      if (nameFieldValue != null) 'name': nameFieldValue,
      if (teamName != _sentinel) 'teamName': teamName as String?,
      if (teamNameFieldValue != null) 'teamName': teamNameFieldValue,
      if (from != _sentinel) 'from': from as DateTime?,
      if (fromFieldValue != null) 'from': fromFieldValue,
      if (to != _sentinel) 'to': to as DateTime?,
      if (toFieldValue != null) 'to': toFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is SeasonDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class SeasonQuery
    implements QueryReference<Season, SeasonQuerySnapshot> {
  @override
  SeasonQuery limit(int limit);

  @override
  SeasonQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  SeasonQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  SeasonQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  SeasonQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  SeasonQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  SeasonQuery whereTeamName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  SeasonQuery whereFrom({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  });
  SeasonQuery whereTo({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  });

  SeasonQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  });

  SeasonQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  });

  SeasonQuery orderByTeamName({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  });

  SeasonQuery orderByFrom({
    bool descending = false,
    DateTime? startAt,
    DateTime? startAfter,
    DateTime? endAt,
    DateTime? endBefore,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  });

  SeasonQuery orderByTo({
    bool descending = false,
    DateTime? startAt,
    DateTime? startAfter,
    DateTime? endAt,
    DateTime? endBefore,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  });
}

class _$SeasonQuery extends QueryReference<Season, SeasonQuerySnapshot>
    implements SeasonQuery {
  _$SeasonQuery(
    this._collection, {
    required Query<Season> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<SeasonQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(SeasonQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<SeasonQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(SeasonQuerySnapshot._fromQuerySnapshot);
  }

  @override
  SeasonQuery limit(int limit) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  SeasonQuery limitToLast(int limit) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SeasonQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SeasonFieldMap['name']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery whereTeamName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SeasonFieldMap['teamName']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery whereFrom({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  }) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SeasonFieldMap['from']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery whereTo({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  }) {
    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SeasonFieldMap['to']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SeasonQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SeasonQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SeasonFieldMap['name']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SeasonQuery orderByTeamName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SeasonFieldMap['teamName']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SeasonQuery orderByFrom({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SeasonFieldMap['from']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SeasonQuery orderByTo({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SeasonDocumentSnapshot? startAtDocument,
    SeasonDocumentSnapshot? endAtDocument,
    SeasonDocumentSnapshot? endBeforeDocument,
    SeasonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SeasonFieldMap['to']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SeasonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$SeasonQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class SeasonDocumentSnapshot extends FirestoreDocumentSnapshot<Season> {
  SeasonDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Season> snapshot;

  @override
  SeasonDocumentReference get reference {
    return SeasonDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Season? data;
}

class SeasonQuerySnapshot
    extends FirestoreQuerySnapshot<Season, SeasonQueryDocumentSnapshot> {
  SeasonQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory SeasonQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Season> snapshot,
  ) {
    final docs = snapshot.docs.map(SeasonQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        SeasonDocumentSnapshot._,
      );
    }).toList();

    return SeasonQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<SeasonDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    SeasonDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<SeasonDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Season> snapshot;

  @override
  final List<SeasonQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<SeasonDocumentSnapshot>> docChanges;
}

class SeasonQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Season>
    implements SeasonDocumentSnapshot {
  SeasonQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Season> snapshot;

  @override
  final Season data;

  @override
  SeasonDocumentReference get reference {
    return SeasonDocumentReference(snapshot.reference);
  }
}

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class PlayerCollectionReference
    implements
        PlayerQuery,
        FirestoreCollectionReference<Player, PlayerQuerySnapshot> {
  factory PlayerCollectionReference(
    DocumentReference<Season> parent,
  ) = _$PlayerCollectionReference;

  static Player fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Player.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Player value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Player> get reference;

  /// A reference to the containing [SeasonDocumentReference] if this is a subcollection.
  SeasonDocumentReference get parent;

  @override
  PlayerDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<PlayerDocumentReference> add(Player value);
}

class _$PlayerCollectionReference extends _$PlayerQuery
    implements PlayerCollectionReference {
  factory _$PlayerCollectionReference(
    DocumentReference<Season> parent,
  ) {
    return _$PlayerCollectionReference._(
      SeasonDocumentReference(parent),
      parent.collection('players').withConverter(
            fromFirestore: PlayerCollectionReference.fromFirestore,
            toFirestore: PlayerCollectionReference.toFirestore,
          ),
    );
  }

  _$PlayerCollectionReference._(
    this.parent,
    CollectionReference<Player> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  @override
  final SeasonDocumentReference parent;

  String get path => reference.path;

  @override
  CollectionReference<Player> get reference =>
      super.reference as CollectionReference<Player>;

  @override
  PlayerDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return PlayerDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<PlayerDocumentReference> add(Player value) {
    return reference.add(value).then((ref) => PlayerDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$PlayerCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class PlayerDocumentReference
    extends FirestoreDocumentReference<Player, PlayerDocumentSnapshot> {
  factory PlayerDocumentReference(DocumentReference<Player> reference) =
      _$PlayerDocumentReference;

  DocumentReference<Player> get reference;

  /// A reference to the [PlayerCollectionReference] containing this document.
  PlayerCollectionReference get parent {
    return _$PlayerCollectionReference(
      reference.parent.parent!.withConverter<Season>(
        fromFirestore: SeasonCollectionReference.fromFirestore,
        toFirestore: SeasonCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<PlayerDocumentSnapshot> snapshots();

  @override
  Future<PlayerDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String name,
    FieldValue nameFieldValue,
    DateTime? birthdate,
    FieldValue birthdateFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String name,
    FieldValue nameFieldValue,
    DateTime? birthdate,
    FieldValue birthdateFieldValue,
  });
}

class _$PlayerDocumentReference
    extends FirestoreDocumentReference<Player, PlayerDocumentSnapshot>
    implements PlayerDocumentReference {
  _$PlayerDocumentReference(this.reference);

  @override
  final DocumentReference<Player> reference;

  /// A reference to the [PlayerCollectionReference] containing this document.
  PlayerCollectionReference get parent {
    return _$PlayerCollectionReference(
      reference.parent.parent!.withConverter<Season>(
        fromFirestore: SeasonCollectionReference.fromFirestore,
        toFirestore: SeasonCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<PlayerDocumentSnapshot> snapshots() {
    return reference.snapshots().map(PlayerDocumentSnapshot._);
  }

  @override
  Future<PlayerDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(PlayerDocumentSnapshot._);
  }

  @override
  Future<PlayerDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(PlayerDocumentSnapshot._);
  }

  Future<void> update({
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? birthdate = _sentinel,
    FieldValue? birthdateFieldValue,
  }) async {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      birthdate == _sentinel || birthdateFieldValue == null,
      "Cannot specify both birthdate and birthdateFieldValue",
    );
    final json = {
      if (name != _sentinel) 'name': name as String,
      if (nameFieldValue != null) 'name': nameFieldValue,
      if (birthdate != _sentinel) 'birthdate': birthdate as DateTime?,
      if (birthdateFieldValue != null) 'birthdate': birthdateFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? birthdate = _sentinel,
    FieldValue? birthdateFieldValue,
  }) {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      birthdate == _sentinel || birthdateFieldValue == null,
      "Cannot specify both birthdate and birthdateFieldValue",
    );
    final json = {
      if (name != _sentinel) 'name': name as String,
      if (nameFieldValue != null) 'name': nameFieldValue,
      if (birthdate != _sentinel) 'birthdate': birthdate as DateTime?,
      if (birthdateFieldValue != null) 'birthdate': birthdateFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class PlayerQuery
    implements QueryReference<Player, PlayerQuerySnapshot> {
  @override
  PlayerQuery limit(int limit);

  @override
  PlayerQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  PlayerQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  PlayerQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  PlayerQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PlayerQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PlayerQuery whereBirthdate({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  });

  PlayerQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  });

  PlayerQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  });

  PlayerQuery orderByBirthdate({
    bool descending = false,
    DateTime? startAt,
    DateTime? startAfter,
    DateTime? endAt,
    DateTime? endBefore,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  });
}

class _$PlayerQuery extends QueryReference<Player, PlayerQuerySnapshot>
    implements PlayerQuery {
  _$PlayerQuery(
    this._collection, {
    required Query<Player> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<PlayerQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(PlayerQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<PlayerQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(PlayerQuerySnapshot._fromQuerySnapshot);
  }

  @override
  PlayerQuery limit(int limit) {
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  PlayerQuery limitToLast(int limit) {
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  PlayerQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PlayerQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PlayerQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PlayerQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PlayerFieldMap['name']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PlayerQuery whereBirthdate({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  }) {
    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PlayerFieldMap['birthdate']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PlayerQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PlayerQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$PlayerFieldMap['name']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PlayerQuery orderByBirthdate({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PlayerDocumentSnapshot? startAtDocument,
    PlayerDocumentSnapshot? endAtDocument,
    PlayerDocumentSnapshot? endBeforeDocument,
    PlayerDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$PlayerFieldMap['birthdate']!, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PlayerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$PlayerQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class PlayerDocumentSnapshot extends FirestoreDocumentSnapshot<Player> {
  PlayerDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Player> snapshot;

  @override
  PlayerDocumentReference get reference {
    return PlayerDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Player? data;
}

class PlayerQuerySnapshot
    extends FirestoreQuerySnapshot<Player, PlayerQueryDocumentSnapshot> {
  PlayerQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory PlayerQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Player> snapshot,
  ) {
    final docs = snapshot.docs.map(PlayerQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        PlayerDocumentSnapshot._,
      );
    }).toList();

    return PlayerQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<PlayerDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    PlayerDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<PlayerDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Player> snapshot;

  @override
  final List<PlayerQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<PlayerDocumentSnapshot>> docChanges;
}

class PlayerQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Player>
    implements PlayerDocumentSnapshot {
  PlayerQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Player> snapshot;

  @override
  final Player data;

  @override
  PlayerDocumentReference get reference {
    return PlayerDocumentReference(snapshot.reference);
  }
}

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class OpponentCollectionReference
    implements
        OpponentQuery,
        FirestoreCollectionReference<Opponent, OpponentQuerySnapshot> {
  factory OpponentCollectionReference(
    DocumentReference<Season> parent,
  ) = _$OpponentCollectionReference;

  static Opponent fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Opponent.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Opponent value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Opponent> get reference;

  /// A reference to the containing [SeasonDocumentReference] if this is a subcollection.
  SeasonDocumentReference get parent;

  @override
  OpponentDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<OpponentDocumentReference> add(Opponent value);
}

class _$OpponentCollectionReference extends _$OpponentQuery
    implements OpponentCollectionReference {
  factory _$OpponentCollectionReference(
    DocumentReference<Season> parent,
  ) {
    return _$OpponentCollectionReference._(
      SeasonDocumentReference(parent),
      parent.collection('opponents').withConverter(
            fromFirestore: OpponentCollectionReference.fromFirestore,
            toFirestore: OpponentCollectionReference.toFirestore,
          ),
    );
  }

  _$OpponentCollectionReference._(
    this.parent,
    CollectionReference<Opponent> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  @override
  final SeasonDocumentReference parent;

  String get path => reference.path;

  @override
  CollectionReference<Opponent> get reference =>
      super.reference as CollectionReference<Opponent>;

  @override
  OpponentDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return OpponentDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<OpponentDocumentReference> add(Opponent value) {
    return reference.add(value).then((ref) => OpponentDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$OpponentCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class OpponentDocumentReference
    extends FirestoreDocumentReference<Opponent, OpponentDocumentSnapshot> {
  factory OpponentDocumentReference(DocumentReference<Opponent> reference) =
      _$OpponentDocumentReference;

  DocumentReference<Opponent> get reference;

  /// A reference to the [OpponentCollectionReference] containing this document.
  OpponentCollectionReference get parent {
    return _$OpponentCollectionReference(
      reference.parent.parent!.withConverter<Season>(
        fromFirestore: SeasonCollectionReference.fromFirestore,
        toFirestore: SeasonCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<OpponentDocumentSnapshot> snapshots();

  @override
  Future<OpponentDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String name,
    FieldValue nameFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String name,
    FieldValue nameFieldValue,
  });
}

class _$OpponentDocumentReference
    extends FirestoreDocumentReference<Opponent, OpponentDocumentSnapshot>
    implements OpponentDocumentReference {
  _$OpponentDocumentReference(this.reference);

  @override
  final DocumentReference<Opponent> reference;

  /// A reference to the [OpponentCollectionReference] containing this document.
  OpponentCollectionReference get parent {
    return _$OpponentCollectionReference(
      reference.parent.parent!.withConverter<Season>(
        fromFirestore: SeasonCollectionReference.fromFirestore,
        toFirestore: SeasonCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<OpponentDocumentSnapshot> snapshots() {
    return reference.snapshots().map(OpponentDocumentSnapshot._);
  }

  @override
  Future<OpponentDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(OpponentDocumentSnapshot._);
  }

  @override
  Future<OpponentDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(OpponentDocumentSnapshot._);
  }

  Future<void> update({
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
  }) async {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    final json = {
      if (name != _sentinel) 'name': name as String,
      if (nameFieldValue != null) 'name': nameFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
  }) {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    final json = {
      if (name != _sentinel) 'name': name as String,
      if (nameFieldValue != null) 'name': nameFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is OpponentDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class OpponentQuery
    implements QueryReference<Opponent, OpponentQuerySnapshot> {
  @override
  OpponentQuery limit(int limit);

  @override
  OpponentQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  OpponentQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    OpponentDocumentSnapshot? startAtDocument,
    OpponentDocumentSnapshot? endAtDocument,
    OpponentDocumentSnapshot? endBeforeDocument,
    OpponentDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  OpponentQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  OpponentQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  OpponentQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });

  OpponentQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    OpponentDocumentSnapshot? startAtDocument,
    OpponentDocumentSnapshot? endAtDocument,
    OpponentDocumentSnapshot? endBeforeDocument,
    OpponentDocumentSnapshot? startAfterDocument,
  });

  OpponentQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    OpponentDocumentSnapshot? startAtDocument,
    OpponentDocumentSnapshot? endAtDocument,
    OpponentDocumentSnapshot? endBeforeDocument,
    OpponentDocumentSnapshot? startAfterDocument,
  });
}

class _$OpponentQuery extends QueryReference<Opponent, OpponentQuerySnapshot>
    implements OpponentQuery {
  _$OpponentQuery(
    this._collection, {
    required Query<Opponent> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<OpponentQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(OpponentQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<OpponentQuerySnapshot> get([GetOptions? options]) {
    return reference
        .get(options)
        .then(OpponentQuerySnapshot._fromQuerySnapshot);
  }

  @override
  OpponentQuery limit(int limit) {
    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  OpponentQuery limitToLast(int limit) {
    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  OpponentQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OpponentDocumentSnapshot? startAtDocument,
    OpponentDocumentSnapshot? endAtDocument,
    OpponentDocumentSnapshot? endBeforeDocument,
    OpponentDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  OpponentQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  OpponentQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  OpponentQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$OpponentFieldMap['name']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  OpponentQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OpponentDocumentSnapshot? startAtDocument,
    OpponentDocumentSnapshot? endAtDocument,
    OpponentDocumentSnapshot? endBeforeDocument,
    OpponentDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  OpponentQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OpponentDocumentSnapshot? startAtDocument,
    OpponentDocumentSnapshot? endAtDocument,
    OpponentDocumentSnapshot? endBeforeDocument,
    OpponentDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$OpponentFieldMap['name']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$OpponentQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$OpponentQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class OpponentDocumentSnapshot extends FirestoreDocumentSnapshot<Opponent> {
  OpponentDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Opponent> snapshot;

  @override
  OpponentDocumentReference get reference {
    return OpponentDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Opponent? data;
}

class OpponentQuerySnapshot
    extends FirestoreQuerySnapshot<Opponent, OpponentQueryDocumentSnapshot> {
  OpponentQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory OpponentQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Opponent> snapshot,
  ) {
    final docs = snapshot.docs.map(OpponentQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        OpponentDocumentSnapshot._,
      );
    }).toList();

    return OpponentQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<OpponentDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    OpponentDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<OpponentDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Opponent> snapshot;

  @override
  final List<OpponentQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<OpponentDocumentSnapshot>> docChanges;
}

class OpponentQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<Opponent>
    implements OpponentDocumentSnapshot {
  OpponentQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Opponent> snapshot;

  @override
  final Opponent data;

  @override
  OpponentDocumentReference get reference {
    return OpponentDocumentReference(snapshot.reference);
  }
}

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class MatchCollectionReference
    implements
        MatchQuery,
        FirestoreCollectionReference<Match, MatchQuerySnapshot> {
  factory MatchCollectionReference(
    DocumentReference<Season> parent,
  ) = _$MatchCollectionReference;

  static Match fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Match.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Match value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Match> get reference;

  /// A reference to the containing [SeasonDocumentReference] if this is a subcollection.
  SeasonDocumentReference get parent;

  @override
  MatchDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<MatchDocumentReference> add(Match value);
}

class _$MatchCollectionReference extends _$MatchQuery
    implements MatchCollectionReference {
  factory _$MatchCollectionReference(
    DocumentReference<Season> parent,
  ) {
    return _$MatchCollectionReference._(
      SeasonDocumentReference(parent),
      parent.collection('matchs').withConverter(
            fromFirestore: MatchCollectionReference.fromFirestore,
            toFirestore: MatchCollectionReference.toFirestore,
          ),
    );
  }

  _$MatchCollectionReference._(
    this.parent,
    CollectionReference<Match> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  @override
  final SeasonDocumentReference parent;

  String get path => reference.path;

  @override
  CollectionReference<Match> get reference =>
      super.reference as CollectionReference<Match>;

  @override
  MatchDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return MatchDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<MatchDocumentReference> add(Match value) {
    return reference.add(value).then((ref) => MatchDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$MatchCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class MatchDocumentReference
    extends FirestoreDocumentReference<Match, MatchDocumentSnapshot> {
  factory MatchDocumentReference(DocumentReference<Match> reference) =
      _$MatchDocumentReference;

  DocumentReference<Match> get reference;

  /// A reference to the [MatchCollectionReference] containing this document.
  MatchCollectionReference get parent {
    return _$MatchCollectionReference(
      reference.parent.parent!.withConverter<Season>(
        fromFirestore: SeasonCollectionReference.fromFirestore,
        toFirestore: SeasonCollectionReference.toFirestore,
      ),
    );
  }

  late final GoalCollectionReference goals = _$GoalCollectionReference(
    reference,
  );

  late final SubstituteCollectionReference substitutes =
      _$SubstituteCollectionReference(
    reference,
  );

  @override
  Stream<MatchDocumentSnapshot> snapshots();

  @override
  Future<MatchDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    DateTime? date,
    FieldValue dateFieldValue,
    int? scoreOpponent,
    FieldValue scoreOpponentFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    DateTime? date,
    FieldValue dateFieldValue,
    int? scoreOpponent,
    FieldValue scoreOpponentFieldValue,
  });
}

class _$MatchDocumentReference
    extends FirestoreDocumentReference<Match, MatchDocumentSnapshot>
    implements MatchDocumentReference {
  _$MatchDocumentReference(this.reference);

  @override
  final DocumentReference<Match> reference;

  /// A reference to the [MatchCollectionReference] containing this document.
  MatchCollectionReference get parent {
    return _$MatchCollectionReference(
      reference.parent.parent!.withConverter<Season>(
        fromFirestore: SeasonCollectionReference.fromFirestore,
        toFirestore: SeasonCollectionReference.toFirestore,
      ),
    );
  }

  late final GoalCollectionReference goals = _$GoalCollectionReference(
    reference,
  );

  late final SubstituteCollectionReference substitutes =
      _$SubstituteCollectionReference(
    reference,
  );

  @override
  Stream<MatchDocumentSnapshot> snapshots() {
    return reference.snapshots().map(MatchDocumentSnapshot._);
  }

  @override
  Future<MatchDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(MatchDocumentSnapshot._);
  }

  @override
  Future<MatchDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(MatchDocumentSnapshot._);
  }

  Future<void> update({
    Object? date = _sentinel,
    FieldValue? dateFieldValue,
    Object? scoreOpponent = _sentinel,
    FieldValue? scoreOpponentFieldValue,
  }) async {
    assert(
      date == _sentinel || dateFieldValue == null,
      "Cannot specify both date and dateFieldValue",
    );
    assert(
      scoreOpponent == _sentinel || scoreOpponentFieldValue == null,
      "Cannot specify both scoreOpponent and scoreOpponentFieldValue",
    );
    final json = {
      if (date != _sentinel) 'date': date as DateTime?,
      if (dateFieldValue != null) 'date': dateFieldValue,
      if (scoreOpponent != _sentinel) 'scoreOpponent': scoreOpponent as int?,
      if (scoreOpponentFieldValue != null)
        'scoreOpponent': scoreOpponentFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? date = _sentinel,
    FieldValue? dateFieldValue,
    Object? scoreOpponent = _sentinel,
    FieldValue? scoreOpponentFieldValue,
  }) {
    assert(
      date == _sentinel || dateFieldValue == null,
      "Cannot specify both date and dateFieldValue",
    );
    assert(
      scoreOpponent == _sentinel || scoreOpponentFieldValue == null,
      "Cannot specify both scoreOpponent and scoreOpponentFieldValue",
    );
    final json = {
      if (date != _sentinel) 'date': date as DateTime?,
      if (dateFieldValue != null) 'date': dateFieldValue,
      if (scoreOpponent != _sentinel) 'scoreOpponent': scoreOpponent as int?,
      if (scoreOpponentFieldValue != null)
        'scoreOpponent': scoreOpponentFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is MatchDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class MatchQuery implements QueryReference<Match, MatchQuerySnapshot> {
  @override
  MatchQuery limit(int limit);

  @override
  MatchQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  MatchQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  MatchQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  MatchQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  MatchQuery whereDate({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  });
  MatchQuery whereScoreOpponent({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int?>? whereIn,
    List<int?>? whereNotIn,
  });

  MatchQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  });

  MatchQuery orderByDate({
    bool descending = false,
    DateTime? startAt,
    DateTime? startAfter,
    DateTime? endAt,
    DateTime? endBefore,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  });

  MatchQuery orderByScoreOpponent({
    bool descending = false,
    int? startAt,
    int? startAfter,
    int? endAt,
    int? endBefore,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  });
}

class _$MatchQuery extends QueryReference<Match, MatchQuerySnapshot>
    implements MatchQuery {
  _$MatchQuery(
    this._collection, {
    required Query<Match> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<MatchQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(MatchQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<MatchQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(MatchQuerySnapshot._fromQuerySnapshot);
  }

  @override
  MatchQuery limit(int limit) {
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  MatchQuery limitToLast(int limit) {
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  MatchQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  MatchQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  MatchQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  MatchQuery whereDate({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  }) {
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$MatchFieldMap['date']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  MatchQuery whereScoreOpponent({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int?>? whereIn,
    List<int?>? whereNotIn,
  }) {
    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$MatchFieldMap['scoreOpponent']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  MatchQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  MatchQuery orderByDate({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$MatchFieldMap['date']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  MatchQuery orderByScoreOpponent({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    MatchDocumentSnapshot? startAtDocument,
    MatchDocumentSnapshot? endAtDocument,
    MatchDocumentSnapshot? endBeforeDocument,
    MatchDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$MatchFieldMap['scoreOpponent']!, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$MatchQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$MatchQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class MatchDocumentSnapshot extends FirestoreDocumentSnapshot<Match> {
  MatchDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Match> snapshot;

  @override
  MatchDocumentReference get reference {
    return MatchDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Match? data;
}

class MatchQuerySnapshot
    extends FirestoreQuerySnapshot<Match, MatchQueryDocumentSnapshot> {
  MatchQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory MatchQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Match> snapshot,
  ) {
    final docs = snapshot.docs.map(MatchQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        MatchDocumentSnapshot._,
      );
    }).toList();

    return MatchQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<MatchDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    MatchDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<MatchDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Match> snapshot;

  @override
  final List<MatchQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<MatchDocumentSnapshot>> docChanges;
}

class MatchQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Match>
    implements MatchDocumentSnapshot {
  MatchQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Match> snapshot;

  @override
  final Match data;

  @override
  MatchDocumentReference get reference {
    return MatchDocumentReference(snapshot.reference);
  }
}

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class GoalCollectionReference
    implements
        GoalQuery,
        FirestoreCollectionReference<Goal, GoalQuerySnapshot> {
  factory GoalCollectionReference(
    DocumentReference<Match> parent,
  ) = _$GoalCollectionReference;

  static Goal fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Goal.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Goal value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Goal> get reference;

  /// A reference to the containing [MatchDocumentReference] if this is a subcollection.
  MatchDocumentReference get parent;

  @override
  GoalDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<GoalDocumentReference> add(Goal value);
}

class _$GoalCollectionReference extends _$GoalQuery
    implements GoalCollectionReference {
  factory _$GoalCollectionReference(
    DocumentReference<Match> parent,
  ) {
    return _$GoalCollectionReference._(
      MatchDocumentReference(parent),
      parent.collection('goals').withConverter(
            fromFirestore: GoalCollectionReference.fromFirestore,
            toFirestore: GoalCollectionReference.toFirestore,
          ),
    );
  }

  _$GoalCollectionReference._(
    this.parent,
    CollectionReference<Goal> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  @override
  final MatchDocumentReference parent;

  String get path => reference.path;

  @override
  CollectionReference<Goal> get reference =>
      super.reference as CollectionReference<Goal>;

  @override
  GoalDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return GoalDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<GoalDocumentReference> add(Goal value) {
    return reference.add(value).then((ref) => GoalDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$GoalCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class GoalDocumentReference
    extends FirestoreDocumentReference<Goal, GoalDocumentSnapshot> {
  factory GoalDocumentReference(DocumentReference<Goal> reference) =
      _$GoalDocumentReference;

  DocumentReference<Goal> get reference;

  /// A reference to the [GoalCollectionReference] containing this document.
  GoalCollectionReference get parent {
    return _$GoalCollectionReference(
      reference.parent.parent!.withConverter<Match>(
        fromFirestore: MatchCollectionReference.fromFirestore,
        toFirestore: MatchCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<GoalDocumentSnapshot> snapshots();

  @override
  Future<GoalDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    int? time,
    FieldValue timeFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    int? time,
    FieldValue timeFieldValue,
  });
}

class _$GoalDocumentReference
    extends FirestoreDocumentReference<Goal, GoalDocumentSnapshot>
    implements GoalDocumentReference {
  _$GoalDocumentReference(this.reference);

  @override
  final DocumentReference<Goal> reference;

  /// A reference to the [GoalCollectionReference] containing this document.
  GoalCollectionReference get parent {
    return _$GoalCollectionReference(
      reference.parent.parent!.withConverter<Match>(
        fromFirestore: MatchCollectionReference.fromFirestore,
        toFirestore: MatchCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<GoalDocumentSnapshot> snapshots() {
    return reference.snapshots().map(GoalDocumentSnapshot._);
  }

  @override
  Future<GoalDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(GoalDocumentSnapshot._);
  }

  @override
  Future<GoalDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(GoalDocumentSnapshot._);
  }

  Future<void> update({
    Object? time = _sentinel,
    FieldValue? timeFieldValue,
  }) async {
    assert(
      time == _sentinel || timeFieldValue == null,
      "Cannot specify both time and timeFieldValue",
    );
    final json = {
      if (time != _sentinel) 'time': time as int?,
      if (timeFieldValue != null) 'time': timeFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? time = _sentinel,
    FieldValue? timeFieldValue,
  }) {
    assert(
      time == _sentinel || timeFieldValue == null,
      "Cannot specify both time and timeFieldValue",
    );
    final json = {
      if (time != _sentinel) 'time': time as int?,
      if (timeFieldValue != null) 'time': timeFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is GoalDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class GoalQuery implements QueryReference<Goal, GoalQuerySnapshot> {
  @override
  GoalQuery limit(int limit);

  @override
  GoalQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  GoalQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    GoalDocumentSnapshot? startAtDocument,
    GoalDocumentSnapshot? endAtDocument,
    GoalDocumentSnapshot? endBeforeDocument,
    GoalDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  GoalQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  GoalQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  GoalQuery whereTime({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int?>? whereIn,
    List<int?>? whereNotIn,
  });

  GoalQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    GoalDocumentSnapshot? startAtDocument,
    GoalDocumentSnapshot? endAtDocument,
    GoalDocumentSnapshot? endBeforeDocument,
    GoalDocumentSnapshot? startAfterDocument,
  });

  GoalQuery orderByTime({
    bool descending = false,
    int? startAt,
    int? startAfter,
    int? endAt,
    int? endBefore,
    GoalDocumentSnapshot? startAtDocument,
    GoalDocumentSnapshot? endAtDocument,
    GoalDocumentSnapshot? endBeforeDocument,
    GoalDocumentSnapshot? startAfterDocument,
  });
}

class _$GoalQuery extends QueryReference<Goal, GoalQuerySnapshot>
    implements GoalQuery {
  _$GoalQuery(
    this._collection, {
    required Query<Goal> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<GoalQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(GoalQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<GoalQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(GoalQuerySnapshot._fromQuerySnapshot);
  }

  @override
  GoalQuery limit(int limit) {
    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  GoalQuery limitToLast(int limit) {
    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  GoalQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    GoalDocumentSnapshot? startAtDocument,
    GoalDocumentSnapshot? endAtDocument,
    GoalDocumentSnapshot? endBeforeDocument,
    GoalDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  GoalQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  GoalQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  GoalQuery whereTime({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int?>? whereIn,
    List<int?>? whereNotIn,
  }) {
    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$GoalFieldMap['time']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  GoalQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    GoalDocumentSnapshot? startAtDocument,
    GoalDocumentSnapshot? endAtDocument,
    GoalDocumentSnapshot? endBeforeDocument,
    GoalDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  GoalQuery orderByTime({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    GoalDocumentSnapshot? startAtDocument,
    GoalDocumentSnapshot? endAtDocument,
    GoalDocumentSnapshot? endBeforeDocument,
    GoalDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$GoalFieldMap['time']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$GoalQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$GoalQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class GoalDocumentSnapshot extends FirestoreDocumentSnapshot<Goal> {
  GoalDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Goal> snapshot;

  @override
  GoalDocumentReference get reference {
    return GoalDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Goal? data;
}

class GoalQuerySnapshot
    extends FirestoreQuerySnapshot<Goal, GoalQueryDocumentSnapshot> {
  GoalQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory GoalQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Goal> snapshot,
  ) {
    final docs = snapshot.docs.map(GoalQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        GoalDocumentSnapshot._,
      );
    }).toList();

    return GoalQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<GoalDocumentSnapshot> _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    GoalDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<GoalDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Goal> snapshot;

  @override
  final List<GoalQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<GoalDocumentSnapshot>> docChanges;
}

class GoalQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Goal>
    implements GoalDocumentSnapshot {
  GoalQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Goal> snapshot;

  @override
  final Goal data;

  @override
  GoalDocumentReference get reference {
    return GoalDocumentReference(snapshot.reference);
  }
}

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class SubstituteCollectionReference
    implements
        SubstituteQuery,
        FirestoreCollectionReference<Substitute, SubstituteQuerySnapshot> {
  factory SubstituteCollectionReference(
    DocumentReference<Match> parent,
  ) = _$SubstituteCollectionReference;

  static Substitute fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Substitute.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Substitute value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Substitute> get reference;

  /// A reference to the containing [MatchDocumentReference] if this is a subcollection.
  MatchDocumentReference get parent;

  @override
  SubstituteDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<SubstituteDocumentReference> add(Substitute value);
}

class _$SubstituteCollectionReference extends _$SubstituteQuery
    implements SubstituteCollectionReference {
  factory _$SubstituteCollectionReference(
    DocumentReference<Match> parent,
  ) {
    return _$SubstituteCollectionReference._(
      MatchDocumentReference(parent),
      parent.collection('substitutes').withConverter(
            fromFirestore: SubstituteCollectionReference.fromFirestore,
            toFirestore: SubstituteCollectionReference.toFirestore,
          ),
    );
  }

  _$SubstituteCollectionReference._(
    this.parent,
    CollectionReference<Substitute> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  @override
  final MatchDocumentReference parent;

  String get path => reference.path;

  @override
  CollectionReference<Substitute> get reference =>
      super.reference as CollectionReference<Substitute>;

  @override
  SubstituteDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return SubstituteDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<SubstituteDocumentReference> add(Substitute value) {
    return reference.add(value).then((ref) => SubstituteDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$SubstituteCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class SubstituteDocumentReference
    extends FirestoreDocumentReference<Substitute, SubstituteDocumentSnapshot> {
  factory SubstituteDocumentReference(DocumentReference<Substitute> reference) =
      _$SubstituteDocumentReference;

  DocumentReference<Substitute> get reference;

  /// A reference to the [SubstituteCollectionReference] containing this document.
  SubstituteCollectionReference get parent {
    return _$SubstituteCollectionReference(
      reference.parent.parent!.withConverter<Match>(
        fromFirestore: MatchCollectionReference.fromFirestore,
        toFirestore: MatchCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<SubstituteDocumentSnapshot> snapshots();

  @override
  Future<SubstituteDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    int? time,
    FieldValue timeFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    int? time,
    FieldValue timeFieldValue,
  });
}

class _$SubstituteDocumentReference
    extends FirestoreDocumentReference<Substitute, SubstituteDocumentSnapshot>
    implements SubstituteDocumentReference {
  _$SubstituteDocumentReference(this.reference);

  @override
  final DocumentReference<Substitute> reference;

  /// A reference to the [SubstituteCollectionReference] containing this document.
  SubstituteCollectionReference get parent {
    return _$SubstituteCollectionReference(
      reference.parent.parent!.withConverter<Match>(
        fromFirestore: MatchCollectionReference.fromFirestore,
        toFirestore: MatchCollectionReference.toFirestore,
      ),
    );
  }

  @override
  Stream<SubstituteDocumentSnapshot> snapshots() {
    return reference.snapshots().map(SubstituteDocumentSnapshot._);
  }

  @override
  Future<SubstituteDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(SubstituteDocumentSnapshot._);
  }

  @override
  Future<SubstituteDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(SubstituteDocumentSnapshot._);
  }

  Future<void> update({
    Object? time = _sentinel,
    FieldValue? timeFieldValue,
  }) async {
    assert(
      time == _sentinel || timeFieldValue == null,
      "Cannot specify both time and timeFieldValue",
    );
    final json = {
      if (time != _sentinel) 'time': time as int?,
      if (timeFieldValue != null) 'time': timeFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? time = _sentinel,
    FieldValue? timeFieldValue,
  }) {
    assert(
      time == _sentinel || timeFieldValue == null,
      "Cannot specify both time and timeFieldValue",
    );
    final json = {
      if (time != _sentinel) 'time': time as int?,
      if (timeFieldValue != null) 'time': timeFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is SubstituteDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class SubstituteQuery
    implements QueryReference<Substitute, SubstituteQuerySnapshot> {
  @override
  SubstituteQuery limit(int limit);

  @override
  SubstituteQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  SubstituteQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    SubstituteDocumentSnapshot? startAtDocument,
    SubstituteDocumentSnapshot? endAtDocument,
    SubstituteDocumentSnapshot? endBeforeDocument,
    SubstituteDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  SubstituteQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  SubstituteQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  SubstituteQuery whereTime({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int?>? whereIn,
    List<int?>? whereNotIn,
  });

  SubstituteQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SubstituteDocumentSnapshot? startAtDocument,
    SubstituteDocumentSnapshot? endAtDocument,
    SubstituteDocumentSnapshot? endBeforeDocument,
    SubstituteDocumentSnapshot? startAfterDocument,
  });

  SubstituteQuery orderByTime({
    bool descending = false,
    int? startAt,
    int? startAfter,
    int? endAt,
    int? endBefore,
    SubstituteDocumentSnapshot? startAtDocument,
    SubstituteDocumentSnapshot? endAtDocument,
    SubstituteDocumentSnapshot? endBeforeDocument,
    SubstituteDocumentSnapshot? startAfterDocument,
  });
}

class _$SubstituteQuery
    extends QueryReference<Substitute, SubstituteQuerySnapshot>
    implements SubstituteQuery {
  _$SubstituteQuery(
    this._collection, {
    required Query<Substitute> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<SubstituteQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference
        .snapshots()
        .map(SubstituteQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<SubstituteQuerySnapshot> get([GetOptions? options]) {
    return reference
        .get(options)
        .then(SubstituteQuerySnapshot._fromQuerySnapshot);
  }

  @override
  SubstituteQuery limit(int limit) {
    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  SubstituteQuery limitToLast(int limit) {
    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  SubstituteQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SubstituteDocumentSnapshot? startAtDocument,
    SubstituteDocumentSnapshot? endAtDocument,
    SubstituteDocumentSnapshot? endBeforeDocument,
    SubstituteDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SubstituteQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SubstituteQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SubstituteQuery whereTime({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int?>? whereIn,
    List<int?>? whereNotIn,
  }) {
    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SubstituteFieldMap['time']!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  SubstituteQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SubstituteDocumentSnapshot? startAtDocument,
    SubstituteDocumentSnapshot? endAtDocument,
    SubstituteDocumentSnapshot? endBeforeDocument,
    SubstituteDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SubstituteQuery orderByTime({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SubstituteDocumentSnapshot? startAtDocument,
    SubstituteDocumentSnapshot? endAtDocument,
    SubstituteDocumentSnapshot? endBeforeDocument,
    SubstituteDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SubstituteFieldMap['time']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$SubstituteQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$SubstituteQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class SubstituteDocumentSnapshot extends FirestoreDocumentSnapshot<Substitute> {
  SubstituteDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Substitute> snapshot;

  @override
  SubstituteDocumentReference get reference {
    return SubstituteDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Substitute? data;
}

class SubstituteQuerySnapshot extends FirestoreQuerySnapshot<Substitute,
    SubstituteQueryDocumentSnapshot> {
  SubstituteQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory SubstituteQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Substitute> snapshot,
  ) {
    final docs = snapshot.docs.map(SubstituteQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        SubstituteDocumentSnapshot._,
      );
    }).toList();

    return SubstituteQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<SubstituteDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    SubstituteDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<SubstituteDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Substitute> snapshot;

  @override
  final List<SubstituteQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<SubstituteDocumentSnapshot>> docChanges;
}

class SubstituteQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<Substitute>
    implements SubstituteDocumentSnapshot {
  SubstituteQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Substitute> snapshot;

  @override
  final Substitute data;

  @override
  SubstituteDocumentReference get reference {
    return SubstituteDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      name: json['name'] as String,
      teamName: json['team_name'] as String?,
      from: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['from'], const DateTimeConverter().fromJson),
      to: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['to'], const DateTimeConverter().fromJson),
    );

const _$SeasonFieldMap = <String, String>{
  'name': 'name',
  'teamName': 'team_name',
  'from': 'from',
  'to': 'to',
};

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'name': instance.name,
      'team_name': instance.teamName,
      'from': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.from, const DateTimeConverter().toJson),
      'to': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.to, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      opponentRef:
          const DocumentReferenceConverter().fromJson(json['opponent']),
      date: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['date'], const DateTimeConverter().fromJson),
      scoreOpponent: json['score_opponent'] as int? ?? 0,
    );

const _$MatchFieldMap = <String, String>{
  'opponentRef': 'opponent',
  'date': 'date',
  'scoreOpponent': 'score_opponent',
};

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'opponent':
          const DocumentReferenceConverter().toJson(instance.opponentRef),
      'date': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.date, const DateTimeConverter().toJson),
      'score_opponent': instance.scoreOpponent,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      name: json['name'] as String,
      birthdate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['birthdate'], const DateTimeConverter().fromJson),
      role: _$JsonConverterFromJson<String, PlayerRoleEnum>(
          json['role'], const PlayerRoleConverter().fromJson),
    );

const _$PlayerFieldMap = <String, String>{
  'name': 'name',
  'birthdate': 'birthdate',
  'role': 'role',
};

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'birthdate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.birthdate, const DateTimeConverter().toJson),
      'role': _$JsonConverterToJson<String, PlayerRoleEnum>(
          instance.role, const PlayerRoleConverter().toJson),
    };

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      scorerRef: const DocumentReferenceConverter().fromJson(json['scorer']),
      passerRef: const DocumentReferenceConverter().fromJson(json['passer']),
      time: json['time'] as int?,
    );

const _$GoalFieldMap = <String, String>{
  'scorerRef': 'scorer',
  'passerRef': 'passer',
  'time': 'time',
};

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'scorer': const DocumentReferenceConverter().toJson(instance.scorerRef),
      'passer': const DocumentReferenceConverter().toJson(instance.passerRef),
      'time': instance.time,
    };

Substitute _$SubstituteFromJson(Map<String, dynamic> json) => Substitute(
      playerInRef:
          const DocumentReferenceConverter().fromJson(json['player_in']),
      playerOutRef:
          const DocumentReferenceConverter().fromJson(json['player_out']),
      time: json['time'] as int?,
    );

const _$SubstituteFieldMap = <String, String>{
  'playerInRef': 'player_in',
  'playerOutRef': 'player_out',
  'time': 'time',
};

Map<String, dynamic> _$SubstituteToJson(Substitute instance) =>
    <String, dynamic>{
      'player_in':
          const DocumentReferenceConverter().toJson(instance.playerInRef),
      'player_out':
          const DocumentReferenceConverter().toJson(instance.playerOutRef),
      'time': instance.time,
    };

Opponent _$OpponentFromJson(Map<String, dynamic> json) => Opponent(
      name: json['name'] as String,
    );

const _$OpponentFieldMap = <String, String>{
  'name': 'name',
};

Map<String, dynamic> _$OpponentToJson(Opponent instance) => <String, dynamic>{
      'name': instance.name,
    };
