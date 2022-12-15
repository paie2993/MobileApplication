// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
// import 'package:drift/drift.dart';

class Payments extends DataClass implements Insertable<Payments> {
  final int id;
  final int totalSum;
  final int? paidSum;
  final String reason;
  final String address;
  final String? iban;
  const Payments(
      {required this.id,
      required this.totalSum,
      this.paidSum,
      required this.reason,
      required this.address,
      this.iban});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_sum'] = Variable<int>(totalSum);
    if (!nullToAbsent || paidSum != null) {
      map['paid_sum'] = Variable<int>(paidSum);
    }
    map['reason'] = Variable<String>(reason);
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || iban != null) {
      map['iban'] = Variable<String>(iban);
    }
    return map;
  }

  PaymentCompanion toCompanion(bool nullToAbsent) {
    return PaymentCompanion(
      id: Value(id),
      totalSum: Value(totalSum),
      paidSum: paidSum == null && nullToAbsent
          ? const Value.absent()
          : Value(paidSum),
      reason: Value(reason),
      address: Value(address),
      iban: iban == null && nullToAbsent ? const Value.absent() : Value(iban),
    );
  }

  factory Payments.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payments(
      id: serializer.fromJson<int>(json['id']),
      totalSum: serializer.fromJson<int>(json['totalSum']),
      paidSum: serializer.fromJson<int?>(json['paidSum']),
      reason: serializer.fromJson<String>(json['reason']),
      address: serializer.fromJson<String>(json['address']),
      iban: serializer.fromJson<String?>(json['iban']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalSum': serializer.toJson<int>(totalSum),
      'paidSum': serializer.toJson<int?>(paidSum),
      'reason': serializer.toJson<String>(reason),
      'address': serializer.toJson<String>(address),
      'iban': serializer.toJson<String?>(iban),
    };
  }

  Payments copyWith(
          {int? id,
          int? totalSum,
          Value<int?> paidSum = const Value.absent(),
          String? reason,
          String? address,
          Value<String?> iban = const Value.absent()}) =>
      Payments(
        id: id ?? this.id,
        totalSum: totalSum ?? this.totalSum,
        paidSum: paidSum.present ? paidSum.value : this.paidSum,
        reason: reason ?? this.reason,
        address: address ?? this.address,
        iban: iban.present ? iban.value : this.iban,
      );
  @override
  String toString() {
    return (StringBuffer('Payments(')
          ..write('id: $id, ')
          ..write('totalSum: $totalSum, ')
          ..write('paidSum: $paidSum, ')
          ..write('reason: $reason, ')
          ..write('address: $address, ')
          ..write('iban: $iban')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalSum, paidSum, reason, address, iban);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payments &&
          other.id == this.id &&
          other.totalSum == this.totalSum &&
          other.paidSum == this.paidSum &&
          other.reason == this.reason &&
          other.address == this.address &&
          other.iban == this.iban);
}

class PaymentCompanion extends UpdateCompanion<Payments> {
  final Value<int> id;
  final Value<int> totalSum;
  final Value<int?> paidSum;
  final Value<String> reason;
  final Value<String> address;
  final Value<String?> iban;
  const PaymentCompanion({
    this.id = const Value.absent(),
    this.totalSum = const Value.absent(),
    this.paidSum = const Value.absent(),
    this.reason = const Value.absent(),
    this.address = const Value.absent(),
    this.iban = const Value.absent(),
  });
  PaymentCompanion.insert({
    this.id = const Value.absent(),
    required int totalSum,
    this.paidSum = const Value.absent(),
    required String reason,
    required String address,
    this.iban = const Value.absent(),
  })  : totalSum = Value(totalSum),
        reason = Value(reason),
        address = Value(address);
  static Insertable<Payments> custom({
    Expression<int>? id,
    Expression<int>? totalSum,
    Expression<int>? paidSum,
    Expression<String>? reason,
    Expression<String>? address,
    Expression<String>? iban,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalSum != null) 'total_sum': totalSum,
      if (paidSum != null) 'paid_sum': paidSum,
      if (reason != null) 'reason': reason,
      if (address != null) 'address': address,
      if (iban != null) 'iban': iban,
    });
  }

  PaymentCompanion copyWith(
      {Value<int>? id,
      Value<int>? totalSum,
      Value<int?>? paidSum,
      Value<String>? reason,
      Value<String>? address,
      Value<String?>? iban}) {
    return PaymentCompanion(
      id: id ?? this.id,
      totalSum: totalSum ?? this.totalSum,
      paidSum: paidSum ?? this.paidSum,
      reason: reason ?? this.reason,
      address: address ?? this.address,
      iban: iban ?? this.iban,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalSum.present) {
      map['total_sum'] = Variable<int>(totalSum.value);
    }
    if (paidSum.present) {
      map['paid_sum'] = Variable<int>(paidSum.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (iban.present) {
      map['iban'] = Variable<String>(iban.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentCompanion(')
          ..write('id: $id, ')
          ..write('totalSum: $totalSum, ')
          ..write('paidSum: $paidSum, ')
          ..write('reason: $reason, ')
          ..write('address: $address, ')
          ..write('iban: $iban')
          ..write(')'))
        .toString();
  }
}

class $PaymentTable extends Payment with TableInfo<$PaymentTable, Payments> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _totalSumMeta =
      const VerificationMeta('totalSum');
  @override
  late final GeneratedColumn<int> totalSum = GeneratedColumn<int>(
      'total_sum', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paidSumMeta =
      const VerificationMeta('paidSum');
  @override
  late final GeneratedColumn<int> paidSum = GeneratedColumn<int>(
      'paid_sum', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ibanMeta = const VerificationMeta('iban');
  @override
  late final GeneratedColumn<String> iban = GeneratedColumn<String>(
      'iban', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, totalSum, paidSum, reason, address, iban];
  @override
  String get aliasedName => _alias ?? 'payment';
  @override
  String get actualTableName => 'payment';
  @override
  VerificationContext validateIntegrity(Insertable<Payments> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_sum')) {
      context.handle(_totalSumMeta,
          totalSum.isAcceptableOrUnknown(data['total_sum']!, _totalSumMeta));
    } else if (isInserting) {
      context.missing(_totalSumMeta);
    }
    if (data.containsKey('paid_sum')) {
      context.handle(_paidSumMeta,
          paidSum.isAcceptableOrUnknown(data['paid_sum']!, _paidSumMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('iban')) {
      context.handle(
          _ibanMeta, iban.isAcceptableOrUnknown(data['iban']!, _ibanMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payments map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payments(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      totalSum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_sum'])!,
      paidSum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paid_sum']),
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      iban: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iban']),
    );
  }

  @override
  $PaymentTable createAlias(String alias) {
    return $PaymentTable(attachedDatabase, alias);
  }
}

abstract class _$PaymentDatabase extends GeneratedDatabase {
  _$PaymentDatabase(QueryExecutor e) : super(e);
  late final $PaymentTable payment = $PaymentTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [payment];
}
