// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final DateTime date;
  final String product;
  final double amount_kg;
  final String farmer_number;
  final String username;
  final int? zreport_id;
  Sale(
      {required this.id,
      required this.date,
      required this.product,
      required this.amount_kg,
      required this.farmer_number,
      required this.username,
      this.zreport_id});
  factory Sale.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Sale(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      product: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product'])!,
      amount_kg: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_kg'])!,
      farmer_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer_number'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      zreport_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zreport_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['product'] = Variable<String>(product);
    map['amount_kg'] = Variable<double>(amount_kg);
    map['farmer_number'] = Variable<String>(farmer_number);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || zreport_id != null) {
      map['zreport_id'] = Variable<int?>(zreport_id);
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      date: Value(date),
      product: Value(product),
      amount_kg: Value(amount_kg),
      farmer_number: Value(farmer_number),
      username: Value(username),
      zreport_id: zreport_id == null && nullToAbsent
          ? const Value.absent()
          : Value(zreport_id),
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      product: serializer.fromJson<String>(json['product']),
      amount_kg: serializer.fromJson<double>(json['amount_kg']),
      farmer_number: serializer.fromJson<String>(json['farmer_number']),
      username: serializer.fromJson<String>(json['username']),
      zreport_id: serializer.fromJson<int?>(json['zreport_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'product': serializer.toJson<String>(product),
      'amount_kg': serializer.toJson<double>(amount_kg),
      'farmer_number': serializer.toJson<String>(farmer_number),
      'username': serializer.toJson<String>(username),
      'zreport_id': serializer.toJson<int?>(zreport_id),
    };
  }

  Sale copyWith(
          {int? id,
          DateTime? date,
          String? product,
          double? amount_kg,
          String? farmer_number,
          String? username,
          int? zreport_id}) =>
      Sale(
        id: id ?? this.id,
        date: date ?? this.date,
        product: product ?? this.product,
        amount_kg: amount_kg ?? this.amount_kg,
        farmer_number: farmer_number ?? this.farmer_number,
        username: username ?? this.username,
        zreport_id: zreport_id ?? this.zreport_id,
      );
  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number, ')
          ..write('username: $username, ')
          ..write('zreport_id: $zreport_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, product, amount_kg, farmer_number, username, zreport_id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.date == this.date &&
          other.product == this.product &&
          other.amount_kg == this.amount_kg &&
          other.farmer_number == this.farmer_number &&
          other.username == this.username &&
          other.zreport_id == this.zreport_id);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> product;
  final Value<double> amount_kg;
  final Value<String> farmer_number;
  final Value<String> username;
  final Value<int?> zreport_id;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.product = const Value.absent(),
    this.amount_kg = const Value.absent(),
    this.farmer_number = const Value.absent(),
    this.username = const Value.absent(),
    this.zreport_id = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String product,
    required double amount_kg,
    required String farmer_number,
    required String username,
    this.zreport_id = const Value.absent(),
  })  : date = Value(date),
        product = Value(product),
        amount_kg = Value(amount_kg),
        farmer_number = Value(farmer_number),
        username = Value(username);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? product,
    Expression<double>? amount_kg,
    Expression<String>? farmer_number,
    Expression<String>? username,
    Expression<int?>? zreport_id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (product != null) 'product': product,
      if (amount_kg != null) 'amount_kg': amount_kg,
      if (farmer_number != null) 'farmer_number': farmer_number,
      if (username != null) 'username': username,
      if (zreport_id != null) 'zreport_id': zreport_id,
    });
  }

  SalesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? product,
      Value<double>? amount_kg,
      Value<String>? farmer_number,
      Value<String>? username,
      Value<int?>? zreport_id}) {
    return SalesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      product: product ?? this.product,
      amount_kg: amount_kg ?? this.amount_kg,
      farmer_number: farmer_number ?? this.farmer_number,
      username: username ?? this.username,
      zreport_id: zreport_id ?? this.zreport_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (product.present) {
      map['product'] = Variable<String>(product.value);
    }
    if (amount_kg.present) {
      map['amount_kg'] = Variable<double>(amount_kg.value);
    }
    if (farmer_number.present) {
      map['farmer_number'] = Variable<String>(farmer_number.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (zreport_id.present) {
      map['zreport_id'] = Variable<int?>(zreport_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number, ')
          ..write('username: $username, ')
          ..write('zreport_id: $zreport_id')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _productMeta = const VerificationMeta('product');
  @override
  late final GeneratedColumn<String?> product = GeneratedColumn<String?>(
      'product', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amount_kgMeta = const VerificationMeta('amount_kg');
  @override
  late final GeneratedColumn<double?> amount_kg = GeneratedColumn<double?>(
      'amount_kg', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _farmer_numberMeta =
      const VerificationMeta('farmer_number');
  @override
  late final GeneratedColumn<String?> farmer_number = GeneratedColumn<String?>(
      'farmer_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zreport_idMeta = const VerificationMeta('zreport_id');
  @override
  late final GeneratedColumn<int?> zreport_id = GeneratedColumn<int?>(
      'zreport_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, product, amount_kg, farmer_number, username, zreport_id];
  @override
  String get aliasedName => _alias ?? 'sales';
  @override
  String get actualTableName => 'sales';
  @override
  VerificationContext validateIntegrity(Insertable<Sale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product']!, _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('amount_kg')) {
      context.handle(_amount_kgMeta,
          amount_kg.isAcceptableOrUnknown(data['amount_kg']!, _amount_kgMeta));
    } else if (isInserting) {
      context.missing(_amount_kgMeta);
    }
    if (data.containsKey('farmer_number')) {
      context.handle(
          _farmer_numberMeta,
          farmer_number.isAcceptableOrUnknown(
              data['farmer_number']!, _farmer_numberMeta));
    } else if (isInserting) {
      context.missing(_farmer_numberMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('zreport_id')) {
      context.handle(
          _zreport_idMeta,
          zreport_id.isAcceptableOrUnknown(
              data['zreport_id']!, _zreport_idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Sale.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final int id;
  final DateTime date;
  final String product;
  final double amount_kg;
  final String farmer_number;
  final String username;
  final int? zreport_id;
  Purchase(
      {required this.id,
      required this.date,
      required this.product,
      required this.amount_kg,
      required this.farmer_number,
      required this.username,
      this.zreport_id});
  factory Purchase.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Purchase(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      product: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product'])!,
      amount_kg: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_kg'])!,
      farmer_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer_number'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      zreport_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zreport_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['product'] = Variable<String>(product);
    map['amount_kg'] = Variable<double>(amount_kg);
    map['farmer_number'] = Variable<String>(farmer_number);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || zreport_id != null) {
      map['zreport_id'] = Variable<int?>(zreport_id);
    }
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      date: Value(date),
      product: Value(product),
      amount_kg: Value(amount_kg),
      farmer_number: Value(farmer_number),
      username: Value(username),
      zreport_id: zreport_id == null && nullToAbsent
          ? const Value.absent()
          : Value(zreport_id),
    );
  }

  factory Purchase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      product: serializer.fromJson<String>(json['product']),
      amount_kg: serializer.fromJson<double>(json['amount_kg']),
      farmer_number: serializer.fromJson<String>(json['farmer_number']),
      username: serializer.fromJson<String>(json['username']),
      zreport_id: serializer.fromJson<int?>(json['zreport_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'product': serializer.toJson<String>(product),
      'amount_kg': serializer.toJson<double>(amount_kg),
      'farmer_number': serializer.toJson<String>(farmer_number),
      'username': serializer.toJson<String>(username),
      'zreport_id': serializer.toJson<int?>(zreport_id),
    };
  }

  Purchase copyWith(
          {int? id,
          DateTime? date,
          String? product,
          double? amount_kg,
          String? farmer_number,
          String? username,
          int? zreport_id}) =>
      Purchase(
        id: id ?? this.id,
        date: date ?? this.date,
        product: product ?? this.product,
        amount_kg: amount_kg ?? this.amount_kg,
        farmer_number: farmer_number ?? this.farmer_number,
        username: username ?? this.username,
        zreport_id: zreport_id ?? this.zreport_id,
      );
  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number, ')
          ..write('username: $username, ')
          ..write('zreport_id: $zreport_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, product, amount_kg, farmer_number, username, zreport_id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.date == this.date &&
          other.product == this.product &&
          other.amount_kg == this.amount_kg &&
          other.farmer_number == this.farmer_number &&
          other.username == this.username &&
          other.zreport_id == this.zreport_id);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> product;
  final Value<double> amount_kg;
  final Value<String> farmer_number;
  final Value<String> username;
  final Value<int?> zreport_id;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.product = const Value.absent(),
    this.amount_kg = const Value.absent(),
    this.farmer_number = const Value.absent(),
    this.username = const Value.absent(),
    this.zreport_id = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String product,
    required double amount_kg,
    required String farmer_number,
    required String username,
    this.zreport_id = const Value.absent(),
  })  : date = Value(date),
        product = Value(product),
        amount_kg = Value(amount_kg),
        farmer_number = Value(farmer_number),
        username = Value(username);
  static Insertable<Purchase> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? product,
    Expression<double>? amount_kg,
    Expression<String>? farmer_number,
    Expression<String>? username,
    Expression<int?>? zreport_id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (product != null) 'product': product,
      if (amount_kg != null) 'amount_kg': amount_kg,
      if (farmer_number != null) 'farmer_number': farmer_number,
      if (username != null) 'username': username,
      if (zreport_id != null) 'zreport_id': zreport_id,
    });
  }

  PurchasesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? product,
      Value<double>? amount_kg,
      Value<String>? farmer_number,
      Value<String>? username,
      Value<int?>? zreport_id}) {
    return PurchasesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      product: product ?? this.product,
      amount_kg: amount_kg ?? this.amount_kg,
      farmer_number: farmer_number ?? this.farmer_number,
      username: username ?? this.username,
      zreport_id: zreport_id ?? this.zreport_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (product.present) {
      map['product'] = Variable<String>(product.value);
    }
    if (amount_kg.present) {
      map['amount_kg'] = Variable<double>(amount_kg.value);
    }
    if (farmer_number.present) {
      map['farmer_number'] = Variable<String>(farmer_number.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (zreport_id.present) {
      map['zreport_id'] = Variable<int?>(zreport_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number, ')
          ..write('username: $username, ')
          ..write('zreport_id: $zreport_id')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _productMeta = const VerificationMeta('product');
  @override
  late final GeneratedColumn<String?> product = GeneratedColumn<String?>(
      'product', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amount_kgMeta = const VerificationMeta('amount_kg');
  @override
  late final GeneratedColumn<double?> amount_kg = GeneratedColumn<double?>(
      'amount_kg', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _farmer_numberMeta =
      const VerificationMeta('farmer_number');
  @override
  late final GeneratedColumn<String?> farmer_number = GeneratedColumn<String?>(
      'farmer_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zreport_idMeta = const VerificationMeta('zreport_id');
  @override
  late final GeneratedColumn<int?> zreport_id = GeneratedColumn<int?>(
      'zreport_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, product, amount_kg, farmer_number, username, zreport_id];
  @override
  String get aliasedName => _alias ?? 'purchases';
  @override
  String get actualTableName => 'purchases';
  @override
  VerificationContext validateIntegrity(Insertable<Purchase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product']!, _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('amount_kg')) {
      context.handle(_amount_kgMeta,
          amount_kg.isAcceptableOrUnknown(data['amount_kg']!, _amount_kgMeta));
    } else if (isInserting) {
      context.missing(_amount_kgMeta);
    }
    if (data.containsKey('farmer_number')) {
      context.handle(
          _farmer_numberMeta,
          farmer_number.isAcceptableOrUnknown(
              data['farmer_number']!, _farmer_numberMeta));
    } else if (isInserting) {
      context.missing(_farmer_numberMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('zreport_id')) {
      context.handle(
          _zreport_idMeta,
          zreport_id.isAcceptableOrUnknown(
              data['zreport_id']!, _zreport_idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Purchase.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String username;
  final String password;
  User({required this.username, required this.password});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      username: Value(username),
      password: Value(password),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({String? username, String? password}) => User(
        username: username ?? this.username,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(username, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.username == this.username &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> username;
  final Value<String> password;
  const UsersCompanion({
    this.username = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    required String username,
    required String password,
  })  : username = Value(username),
        password = Value(password);
  static Insertable<User> custom({
    Expression<String>? username,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith({Value<String>? username, Value<String>? password}) {
    return UsersCompanion(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [username, password];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class Xreport extends DataClass implements Insertable<Xreport> {
  final String username;
  final int transactions_sold;
  final int transactions_bought;
  final double units_sold;
  final double units_bought;
  Xreport(
      {required this.username,
      required this.transactions_sold,
      required this.transactions_bought,
      required this.units_sold,
      required this.units_bought});
  factory Xreport.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Xreport(
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      transactions_sold: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}transactions_sold'])!,
      transactions_bought: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}transactions_bought'])!,
      units_sold: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_sold'])!,
      units_bought: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_bought'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['username'] = Variable<String>(username);
    map['transactions_sold'] = Variable<int>(transactions_sold);
    map['transactions_bought'] = Variable<int>(transactions_bought);
    map['units_sold'] = Variable<double>(units_sold);
    map['units_bought'] = Variable<double>(units_bought);
    return map;
  }

  XreportsCompanion toCompanion(bool nullToAbsent) {
    return XreportsCompanion(
      username: Value(username),
      transactions_sold: Value(transactions_sold),
      transactions_bought: Value(transactions_bought),
      units_sold: Value(units_sold),
      units_bought: Value(units_bought),
    );
  }

  factory Xreport.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Xreport(
      username: serializer.fromJson<String>(json['username']),
      transactions_sold: serializer.fromJson<int>(json['transactions_sold']),
      transactions_bought:
          serializer.fromJson<int>(json['transactions_bought']),
      units_sold: serializer.fromJson<double>(json['units_sold']),
      units_bought: serializer.fromJson<double>(json['units_bought']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'username': serializer.toJson<String>(username),
      'transactions_sold': serializer.toJson<int>(transactions_sold),
      'transactions_bought': serializer.toJson<int>(transactions_bought),
      'units_sold': serializer.toJson<double>(units_sold),
      'units_bought': serializer.toJson<double>(units_bought),
    };
  }

  Xreport copyWith(
          {String? username,
          int? transactions_sold,
          int? transactions_bought,
          double? units_sold,
          double? units_bought}) =>
      Xreport(
        username: username ?? this.username,
        transactions_sold: transactions_sold ?? this.transactions_sold,
        transactions_bought: transactions_bought ?? this.transactions_bought,
        units_sold: units_sold ?? this.units_sold,
        units_bought: units_bought ?? this.units_bought,
      );
  @override
  String toString() {
    return (StringBuffer('Xreport(')
          ..write('username: $username, ')
          ..write('transactions_sold: $transactions_sold, ')
          ..write('transactions_bought: $transactions_bought, ')
          ..write('units_sold: $units_sold, ')
          ..write('units_bought: $units_bought')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(username, transactions_sold,
      transactions_bought, units_sold, units_bought);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Xreport &&
          other.username == this.username &&
          other.transactions_sold == this.transactions_sold &&
          other.transactions_bought == this.transactions_bought &&
          other.units_sold == this.units_sold &&
          other.units_bought == this.units_bought);
}

class XreportsCompanion extends UpdateCompanion<Xreport> {
  final Value<String> username;
  final Value<int> transactions_sold;
  final Value<int> transactions_bought;
  final Value<double> units_sold;
  final Value<double> units_bought;
  const XreportsCompanion({
    this.username = const Value.absent(),
    this.transactions_sold = const Value.absent(),
    this.transactions_bought = const Value.absent(),
    this.units_sold = const Value.absent(),
    this.units_bought = const Value.absent(),
  });
  XreportsCompanion.insert({
    required String username,
    required int transactions_sold,
    required int transactions_bought,
    required double units_sold,
    required double units_bought,
  })  : username = Value(username),
        transactions_sold = Value(transactions_sold),
        transactions_bought = Value(transactions_bought),
        units_sold = Value(units_sold),
        units_bought = Value(units_bought);
  static Insertable<Xreport> custom({
    Expression<String>? username,
    Expression<int>? transactions_sold,
    Expression<int>? transactions_bought,
    Expression<double>? units_sold,
    Expression<double>? units_bought,
  }) {
    return RawValuesInsertable({
      if (username != null) 'username': username,
      if (transactions_sold != null) 'transactions_sold': transactions_sold,
      if (transactions_bought != null)
        'transactions_bought': transactions_bought,
      if (units_sold != null) 'units_sold': units_sold,
      if (units_bought != null) 'units_bought': units_bought,
    });
  }

  XreportsCompanion copyWith(
      {Value<String>? username,
      Value<int>? transactions_sold,
      Value<int>? transactions_bought,
      Value<double>? units_sold,
      Value<double>? units_bought}) {
    return XreportsCompanion(
      username: username ?? this.username,
      transactions_sold: transactions_sold ?? this.transactions_sold,
      transactions_bought: transactions_bought ?? this.transactions_bought,
      units_sold: units_sold ?? this.units_sold,
      units_bought: units_bought ?? this.units_bought,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (transactions_sold.present) {
      map['transactions_sold'] = Variable<int>(transactions_sold.value);
    }
    if (transactions_bought.present) {
      map['transactions_bought'] = Variable<int>(transactions_bought.value);
    }
    if (units_sold.present) {
      map['units_sold'] = Variable<double>(units_sold.value);
    }
    if (units_bought.present) {
      map['units_bought'] = Variable<double>(units_bought.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XreportsCompanion(')
          ..write('username: $username, ')
          ..write('transactions_sold: $transactions_sold, ')
          ..write('transactions_bought: $transactions_bought, ')
          ..write('units_sold: $units_sold, ')
          ..write('units_bought: $units_bought')
          ..write(')'))
        .toString();
  }
}

class $XreportsTable extends Xreports with TableInfo<$XreportsTable, Xreport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XreportsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _transactions_soldMeta =
      const VerificationMeta('transactions_sold');
  @override
  late final GeneratedColumn<int?> transactions_sold = GeneratedColumn<int?>(
      'transactions_sold', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _transactions_boughtMeta =
      const VerificationMeta('transactions_bought');
  @override
  late final GeneratedColumn<int?> transactions_bought = GeneratedColumn<int?>(
      'transactions_bought', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _units_soldMeta = const VerificationMeta('units_sold');
  @override
  late final GeneratedColumn<double?> units_sold = GeneratedColumn<double?>(
      'units_sold', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _units_boughtMeta =
      const VerificationMeta('units_bought');
  @override
  late final GeneratedColumn<double?> units_bought = GeneratedColumn<double?>(
      'units_bought', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        username,
        transactions_sold,
        transactions_bought,
        units_sold,
        units_bought
      ];
  @override
  String get aliasedName => _alias ?? 'xreports';
  @override
  String get actualTableName => 'xreports';
  @override
  VerificationContext validateIntegrity(Insertable<Xreport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('transactions_sold')) {
      context.handle(
          _transactions_soldMeta,
          transactions_sold.isAcceptableOrUnknown(
              data['transactions_sold']!, _transactions_soldMeta));
    } else if (isInserting) {
      context.missing(_transactions_soldMeta);
    }
    if (data.containsKey('transactions_bought')) {
      context.handle(
          _transactions_boughtMeta,
          transactions_bought.isAcceptableOrUnknown(
              data['transactions_bought']!, _transactions_boughtMeta));
    } else if (isInserting) {
      context.missing(_transactions_boughtMeta);
    }
    if (data.containsKey('units_sold')) {
      context.handle(
          _units_soldMeta,
          units_sold.isAcceptableOrUnknown(
              data['units_sold']!, _units_soldMeta));
    } else if (isInserting) {
      context.missing(_units_soldMeta);
    }
    if (data.containsKey('units_bought')) {
      context.handle(
          _units_boughtMeta,
          units_bought.isAcceptableOrUnknown(
              data['units_bought']!, _units_boughtMeta));
    } else if (isInserting) {
      context.missing(_units_boughtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username};
  @override
  Xreport map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Xreport.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $XreportsTable createAlias(String alias) {
    return $XreportsTable(attachedDatabase, alias);
  }
}

class Zreport extends DataClass implements Insertable<Zreport> {
  final DateTime date;
  final int transactions_sold;
  final int transactions_bought;
  final double units_sold;
  final double units_bought;
  final String username;
  final int zreport_id;
  Zreport(
      {required this.date,
      required this.transactions_sold,
      required this.transactions_bought,
      required this.units_sold,
      required this.units_bought,
      required this.username,
      required this.zreport_id});
  factory Zreport.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Zreport(
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      transactions_sold: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}transactions_sold'])!,
      transactions_bought: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}transactions_bought'])!,
      units_sold: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_sold'])!,
      units_bought: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_bought'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      zreport_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zreport_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['transactions_sold'] = Variable<int>(transactions_sold);
    map['transactions_bought'] = Variable<int>(transactions_bought);
    map['units_sold'] = Variable<double>(units_sold);
    map['units_bought'] = Variable<double>(units_bought);
    map['username'] = Variable<String>(username);
    map['zreport_id'] = Variable<int>(zreport_id);
    return map;
  }

  ZreportsCompanion toCompanion(bool nullToAbsent) {
    return ZreportsCompanion(
      date: Value(date),
      transactions_sold: Value(transactions_sold),
      transactions_bought: Value(transactions_bought),
      units_sold: Value(units_sold),
      units_bought: Value(units_bought),
      username: Value(username),
      zreport_id: Value(zreport_id),
    );
  }

  factory Zreport.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Zreport(
      date: serializer.fromJson<DateTime>(json['date']),
      transactions_sold: serializer.fromJson<int>(json['transactions_sold']),
      transactions_bought:
          serializer.fromJson<int>(json['transactions_bought']),
      units_sold: serializer.fromJson<double>(json['units_sold']),
      units_bought: serializer.fromJson<double>(json['units_bought']),
      username: serializer.fromJson<String>(json['username']),
      zreport_id: serializer.fromJson<int>(json['zreport_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'transactions_sold': serializer.toJson<int>(transactions_sold),
      'transactions_bought': serializer.toJson<int>(transactions_bought),
      'units_sold': serializer.toJson<double>(units_sold),
      'units_bought': serializer.toJson<double>(units_bought),
      'username': serializer.toJson<String>(username),
      'zreport_id': serializer.toJson<int>(zreport_id),
    };
  }

  Zreport copyWith(
          {DateTime? date,
          int? transactions_sold,
          int? transactions_bought,
          double? units_sold,
          double? units_bought,
          String? username,
          int? zreport_id}) =>
      Zreport(
        date: date ?? this.date,
        transactions_sold: transactions_sold ?? this.transactions_sold,
        transactions_bought: transactions_bought ?? this.transactions_bought,
        units_sold: units_sold ?? this.units_sold,
        units_bought: units_bought ?? this.units_bought,
        username: username ?? this.username,
        zreport_id: zreport_id ?? this.zreport_id,
      );
  @override
  String toString() {
    return (StringBuffer('Zreport(')
          ..write('date: $date, ')
          ..write('transactions_sold: $transactions_sold, ')
          ..write('transactions_bought: $transactions_bought, ')
          ..write('units_sold: $units_sold, ')
          ..write('units_bought: $units_bought, ')
          ..write('username: $username, ')
          ..write('zreport_id: $zreport_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, transactions_sold, transactions_bought,
      units_sold, units_bought, username, zreport_id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Zreport &&
          other.date == this.date &&
          other.transactions_sold == this.transactions_sold &&
          other.transactions_bought == this.transactions_bought &&
          other.units_sold == this.units_sold &&
          other.units_bought == this.units_bought &&
          other.username == this.username &&
          other.zreport_id == this.zreport_id);
}

class ZreportsCompanion extends UpdateCompanion<Zreport> {
  final Value<DateTime> date;
  final Value<int> transactions_sold;
  final Value<int> transactions_bought;
  final Value<double> units_sold;
  final Value<double> units_bought;
  final Value<String> username;
  final Value<int> zreport_id;
  const ZreportsCompanion({
    this.date = const Value.absent(),
    this.transactions_sold = const Value.absent(),
    this.transactions_bought = const Value.absent(),
    this.units_sold = const Value.absent(),
    this.units_bought = const Value.absent(),
    this.username = const Value.absent(),
    this.zreport_id = const Value.absent(),
  });
  ZreportsCompanion.insert({
    required DateTime date,
    required int transactions_sold,
    required int transactions_bought,
    required double units_sold,
    required double units_bought,
    required String username,
    this.zreport_id = const Value.absent(),
  })  : date = Value(date),
        transactions_sold = Value(transactions_sold),
        transactions_bought = Value(transactions_bought),
        units_sold = Value(units_sold),
        units_bought = Value(units_bought),
        username = Value(username);
  static Insertable<Zreport> custom({
    Expression<DateTime>? date,
    Expression<int>? transactions_sold,
    Expression<int>? transactions_bought,
    Expression<double>? units_sold,
    Expression<double>? units_bought,
    Expression<String>? username,
    Expression<int>? zreport_id,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (transactions_sold != null) 'transactions_sold': transactions_sold,
      if (transactions_bought != null)
        'transactions_bought': transactions_bought,
      if (units_sold != null) 'units_sold': units_sold,
      if (units_bought != null) 'units_bought': units_bought,
      if (username != null) 'username': username,
      if (zreport_id != null) 'zreport_id': zreport_id,
    });
  }

  ZreportsCompanion copyWith(
      {Value<DateTime>? date,
      Value<int>? transactions_sold,
      Value<int>? transactions_bought,
      Value<double>? units_sold,
      Value<double>? units_bought,
      Value<String>? username,
      Value<int>? zreport_id}) {
    return ZreportsCompanion(
      date: date ?? this.date,
      transactions_sold: transactions_sold ?? this.transactions_sold,
      transactions_bought: transactions_bought ?? this.transactions_bought,
      units_sold: units_sold ?? this.units_sold,
      units_bought: units_bought ?? this.units_bought,
      username: username ?? this.username,
      zreport_id: zreport_id ?? this.zreport_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (transactions_sold.present) {
      map['transactions_sold'] = Variable<int>(transactions_sold.value);
    }
    if (transactions_bought.present) {
      map['transactions_bought'] = Variable<int>(transactions_bought.value);
    }
    if (units_sold.present) {
      map['units_sold'] = Variable<double>(units_sold.value);
    }
    if (units_bought.present) {
      map['units_bought'] = Variable<double>(units_bought.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (zreport_id.present) {
      map['zreport_id'] = Variable<int>(zreport_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZreportsCompanion(')
          ..write('date: $date, ')
          ..write('transactions_sold: $transactions_sold, ')
          ..write('transactions_bought: $transactions_bought, ')
          ..write('units_sold: $units_sold, ')
          ..write('units_bought: $units_bought, ')
          ..write('username: $username, ')
          ..write('zreport_id: $zreport_id')
          ..write(')'))
        .toString();
  }
}

class $ZreportsTable extends Zreports with TableInfo<$ZreportsTable, Zreport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZreportsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _transactions_soldMeta =
      const VerificationMeta('transactions_sold');
  @override
  late final GeneratedColumn<int?> transactions_sold = GeneratedColumn<int?>(
      'transactions_sold', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _transactions_boughtMeta =
      const VerificationMeta('transactions_bought');
  @override
  late final GeneratedColumn<int?> transactions_bought = GeneratedColumn<int?>(
      'transactions_bought', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _units_soldMeta = const VerificationMeta('units_sold');
  @override
  late final GeneratedColumn<double?> units_sold = GeneratedColumn<double?>(
      'units_sold', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _units_boughtMeta =
      const VerificationMeta('units_bought');
  @override
  late final GeneratedColumn<double?> units_bought = GeneratedColumn<double?>(
      'units_bought', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zreport_idMeta = const VerificationMeta('zreport_id');
  @override
  late final GeneratedColumn<int?> zreport_id = GeneratedColumn<int?>(
      'zreport_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        date,
        transactions_sold,
        transactions_bought,
        units_sold,
        units_bought,
        username,
        zreport_id
      ];
  @override
  String get aliasedName => _alias ?? 'zreports';
  @override
  String get actualTableName => 'zreports';
  @override
  VerificationContext validateIntegrity(Insertable<Zreport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('transactions_sold')) {
      context.handle(
          _transactions_soldMeta,
          transactions_sold.isAcceptableOrUnknown(
              data['transactions_sold']!, _transactions_soldMeta));
    } else if (isInserting) {
      context.missing(_transactions_soldMeta);
    }
    if (data.containsKey('transactions_bought')) {
      context.handle(
          _transactions_boughtMeta,
          transactions_bought.isAcceptableOrUnknown(
              data['transactions_bought']!, _transactions_boughtMeta));
    } else if (isInserting) {
      context.missing(_transactions_boughtMeta);
    }
    if (data.containsKey('units_sold')) {
      context.handle(
          _units_soldMeta,
          units_sold.isAcceptableOrUnknown(
              data['units_sold']!, _units_soldMeta));
    } else if (isInserting) {
      context.missing(_units_soldMeta);
    }
    if (data.containsKey('units_bought')) {
      context.handle(
          _units_boughtMeta,
          units_bought.isAcceptableOrUnknown(
              data['units_bought']!, _units_boughtMeta));
    } else if (isInserting) {
      context.missing(_units_boughtMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('zreport_id')) {
      context.handle(
          _zreport_idMeta,
          zreport_id.isAcceptableOrUnknown(
              data['zreport_id']!, _zreport_idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {zreport_id};
  @override
  Zreport map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Zreport.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ZreportsTable createAlias(String alias) {
    return $ZreportsTable(attachedDatabase, alias);
  }
}

class Buyable_product extends DataClass implements Insertable<Buyable_product> {
  final String product_name;
  Buyable_product({required this.product_name});
  factory Buyable_product.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Buyable_product(
      product_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_name'] = Variable<String>(product_name);
    return map;
  }

  Buyable_productsCompanion toCompanion(bool nullToAbsent) {
    return Buyable_productsCompanion(
      product_name: Value(product_name),
    );
  }

  factory Buyable_product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Buyable_product(
      product_name: serializer.fromJson<String>(json['product_name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'product_name': serializer.toJson<String>(product_name),
    };
  }

  Buyable_product copyWith({String? product_name}) => Buyable_product(
        product_name: product_name ?? this.product_name,
      );
  @override
  String toString() {
    return (StringBuffer('Buyable_product(')
          ..write('product_name: $product_name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => product_name.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Buyable_product && other.product_name == this.product_name);
}

class Buyable_productsCompanion extends UpdateCompanion<Buyable_product> {
  final Value<String> product_name;
  const Buyable_productsCompanion({
    this.product_name = const Value.absent(),
  });
  Buyable_productsCompanion.insert({
    required String product_name,
  }) : product_name = Value(product_name);
  static Insertable<Buyable_product> custom({
    Expression<String>? product_name,
  }) {
    return RawValuesInsertable({
      if (product_name != null) 'product_name': product_name,
    });
  }

  Buyable_productsCompanion copyWith({Value<String>? product_name}) {
    return Buyable_productsCompanion(
      product_name: product_name ?? this.product_name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (product_name.present) {
      map['product_name'] = Variable<String>(product_name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Buyable_productsCompanion(')
          ..write('product_name: $product_name')
          ..write(')'))
        .toString();
  }
}

class $Buyable_productsTable extends Buyable_products
    with TableInfo<$Buyable_productsTable, Buyable_product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Buyable_productsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _product_nameMeta =
      const VerificationMeta('product_name');
  @override
  late final GeneratedColumn<String?> product_name = GeneratedColumn<String?>(
      'product_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [product_name];
  @override
  String get aliasedName => _alias ?? 'buyable_products';
  @override
  String get actualTableName => 'buyable_products';
  @override
  VerificationContext validateIntegrity(Insertable<Buyable_product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_name')) {
      context.handle(
          _product_nameMeta,
          product_name.isAcceptableOrUnknown(
              data['product_name']!, _product_nameMeta));
    } else if (isInserting) {
      context.missing(_product_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {product_name};
  @override
  Buyable_product map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Buyable_product.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $Buyable_productsTable createAlias(String alias) {
    return $Buyable_productsTable(attachedDatabase, alias);
  }
}

class Sellable_product extends DataClass
    implements Insertable<Sellable_product> {
  final String product_name;
  Sellable_product({required this.product_name});
  factory Sellable_product.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Sellable_product(
      product_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_name'] = Variable<String>(product_name);
    return map;
  }

  Sellable_productsCompanion toCompanion(bool nullToAbsent) {
    return Sellable_productsCompanion(
      product_name: Value(product_name),
    );
  }

  factory Sellable_product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sellable_product(
      product_name: serializer.fromJson<String>(json['product_name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'product_name': serializer.toJson<String>(product_name),
    };
  }

  Sellable_product copyWith({String? product_name}) => Sellable_product(
        product_name: product_name ?? this.product_name,
      );
  @override
  String toString() {
    return (StringBuffer('Sellable_product(')
          ..write('product_name: $product_name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => product_name.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sellable_product && other.product_name == this.product_name);
}

class Sellable_productsCompanion extends UpdateCompanion<Sellable_product> {
  final Value<String> product_name;
  const Sellable_productsCompanion({
    this.product_name = const Value.absent(),
  });
  Sellable_productsCompanion.insert({
    required String product_name,
  }) : product_name = Value(product_name);
  static Insertable<Sellable_product> custom({
    Expression<String>? product_name,
  }) {
    return RawValuesInsertable({
      if (product_name != null) 'product_name': product_name,
    });
  }

  Sellable_productsCompanion copyWith({Value<String>? product_name}) {
    return Sellable_productsCompanion(
      product_name: product_name ?? this.product_name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (product_name.present) {
      map['product_name'] = Variable<String>(product_name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Sellable_productsCompanion(')
          ..write('product_name: $product_name')
          ..write(')'))
        .toString();
  }
}

class $Sellable_productsTable extends Sellable_products
    with TableInfo<$Sellable_productsTable, Sellable_product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Sellable_productsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _product_nameMeta =
      const VerificationMeta('product_name');
  @override
  late final GeneratedColumn<String?> product_name = GeneratedColumn<String?>(
      'product_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [product_name];
  @override
  String get aliasedName => _alias ?? 'sellable_products';
  @override
  String get actualTableName => 'sellable_products';
  @override
  VerificationContext validateIntegrity(Insertable<Sellable_product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_name')) {
      context.handle(
          _product_nameMeta,
          product_name.isAcceptableOrUnknown(
              data['product_name']!, _product_nameMeta));
    } else if (isInserting) {
      context.missing(_product_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {product_name};
  @override
  Sellable_product map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Sellable_product.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $Sellable_productsTable createAlias(String alias) {
    return $Sellable_productsTable(attachedDatabase, alias);
  }
}

class TotalSale extends DataClass implements Insertable<TotalSale> {
  final String product;
  final double amount_kg;
  final String farmer_number;
  TotalSale(
      {required this.product,
      required this.amount_kg,
      required this.farmer_number});
  factory TotalSale.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TotalSale(
      product: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product'])!,
      amount_kg: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_kg'])!,
      farmer_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product'] = Variable<String>(product);
    map['amount_kg'] = Variable<double>(amount_kg);
    map['farmer_number'] = Variable<String>(farmer_number);
    return map;
  }

  TotalSalesCompanion toCompanion(bool nullToAbsent) {
    return TotalSalesCompanion(
      product: Value(product),
      amount_kg: Value(amount_kg),
      farmer_number: Value(farmer_number),
    );
  }

  factory TotalSale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TotalSale(
      product: serializer.fromJson<String>(json['product']),
      amount_kg: serializer.fromJson<double>(json['amount_kg']),
      farmer_number: serializer.fromJson<String>(json['farmer_number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'product': serializer.toJson<String>(product),
      'amount_kg': serializer.toJson<double>(amount_kg),
      'farmer_number': serializer.toJson<String>(farmer_number),
    };
  }

  TotalSale copyWith(
          {String? product, double? amount_kg, String? farmer_number}) =>
      TotalSale(
        product: product ?? this.product,
        amount_kg: amount_kg ?? this.amount_kg,
        farmer_number: farmer_number ?? this.farmer_number,
      );
  @override
  String toString() {
    return (StringBuffer('TotalSale(')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(product, amount_kg, farmer_number);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TotalSale &&
          other.product == this.product &&
          other.amount_kg == this.amount_kg &&
          other.farmer_number == this.farmer_number);
}

class TotalSalesCompanion extends UpdateCompanion<TotalSale> {
  final Value<String> product;
  final Value<double> amount_kg;
  final Value<String> farmer_number;
  const TotalSalesCompanion({
    this.product = const Value.absent(),
    this.amount_kg = const Value.absent(),
    this.farmer_number = const Value.absent(),
  });
  TotalSalesCompanion.insert({
    required String product,
    required double amount_kg,
    required String farmer_number,
  })  : product = Value(product),
        amount_kg = Value(amount_kg),
        farmer_number = Value(farmer_number);
  static Insertable<TotalSale> custom({
    Expression<String>? product,
    Expression<double>? amount_kg,
    Expression<String>? farmer_number,
  }) {
    return RawValuesInsertable({
      if (product != null) 'product': product,
      if (amount_kg != null) 'amount_kg': amount_kg,
      if (farmer_number != null) 'farmer_number': farmer_number,
    });
  }

  TotalSalesCompanion copyWith(
      {Value<String>? product,
      Value<double>? amount_kg,
      Value<String>? farmer_number}) {
    return TotalSalesCompanion(
      product: product ?? this.product,
      amount_kg: amount_kg ?? this.amount_kg,
      farmer_number: farmer_number ?? this.farmer_number,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (product.present) {
      map['product'] = Variable<String>(product.value);
    }
    if (amount_kg.present) {
      map['amount_kg'] = Variable<double>(amount_kg.value);
    }
    if (farmer_number.present) {
      map['farmer_number'] = Variable<String>(farmer_number.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TotalSalesCompanion(')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number')
          ..write(')'))
        .toString();
  }
}

class $TotalSalesTable extends TotalSales
    with TableInfo<$TotalSalesTable, TotalSale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TotalSalesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _productMeta = const VerificationMeta('product');
  @override
  late final GeneratedColumn<String?> product = GeneratedColumn<String?>(
      'product', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amount_kgMeta = const VerificationMeta('amount_kg');
  @override
  late final GeneratedColumn<double?> amount_kg = GeneratedColumn<double?>(
      'amount_kg', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _farmer_numberMeta =
      const VerificationMeta('farmer_number');
  @override
  late final GeneratedColumn<String?> farmer_number = GeneratedColumn<String?>(
      'farmer_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [product, amount_kg, farmer_number];
  @override
  String get aliasedName => _alias ?? 'total_sales';
  @override
  String get actualTableName => 'total_sales';
  @override
  VerificationContext validateIntegrity(Insertable<TotalSale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product']!, _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('amount_kg')) {
      context.handle(_amount_kgMeta,
          amount_kg.isAcceptableOrUnknown(data['amount_kg']!, _amount_kgMeta));
    } else if (isInserting) {
      context.missing(_amount_kgMeta);
    }
    if (data.containsKey('farmer_number')) {
      context.handle(
          _farmer_numberMeta,
          farmer_number.isAcceptableOrUnknown(
              data['farmer_number']!, _farmer_numberMeta));
    } else if (isInserting) {
      context.missing(_farmer_numberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {product, farmer_number};
  @override
  TotalSale map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TotalSale.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TotalSalesTable createAlias(String alias) {
    return $TotalSalesTable(attachedDatabase, alias);
  }
}

class TotalPurchase extends DataClass implements Insertable<TotalPurchase> {
  final String product;
  final double amount_kg;
  final String farmer_number;
  TotalPurchase(
      {required this.product,
      required this.amount_kg,
      required this.farmer_number});
  factory TotalPurchase.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TotalPurchase(
      product: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product'])!,
      amount_kg: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_kg'])!,
      farmer_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product'] = Variable<String>(product);
    map['amount_kg'] = Variable<double>(amount_kg);
    map['farmer_number'] = Variable<String>(farmer_number);
    return map;
  }

  TotalPurchasesCompanion toCompanion(bool nullToAbsent) {
    return TotalPurchasesCompanion(
      product: Value(product),
      amount_kg: Value(amount_kg),
      farmer_number: Value(farmer_number),
    );
  }

  factory TotalPurchase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TotalPurchase(
      product: serializer.fromJson<String>(json['product']),
      amount_kg: serializer.fromJson<double>(json['amount_kg']),
      farmer_number: serializer.fromJson<String>(json['farmer_number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'product': serializer.toJson<String>(product),
      'amount_kg': serializer.toJson<double>(amount_kg),
      'farmer_number': serializer.toJson<String>(farmer_number),
    };
  }

  TotalPurchase copyWith(
          {String? product, double? amount_kg, String? farmer_number}) =>
      TotalPurchase(
        product: product ?? this.product,
        amount_kg: amount_kg ?? this.amount_kg,
        farmer_number: farmer_number ?? this.farmer_number,
      );
  @override
  String toString() {
    return (StringBuffer('TotalPurchase(')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(product, amount_kg, farmer_number);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TotalPurchase &&
          other.product == this.product &&
          other.amount_kg == this.amount_kg &&
          other.farmer_number == this.farmer_number);
}

class TotalPurchasesCompanion extends UpdateCompanion<TotalPurchase> {
  final Value<String> product;
  final Value<double> amount_kg;
  final Value<String> farmer_number;
  const TotalPurchasesCompanion({
    this.product = const Value.absent(),
    this.amount_kg = const Value.absent(),
    this.farmer_number = const Value.absent(),
  });
  TotalPurchasesCompanion.insert({
    required String product,
    required double amount_kg,
    required String farmer_number,
  })  : product = Value(product),
        amount_kg = Value(amount_kg),
        farmer_number = Value(farmer_number);
  static Insertable<TotalPurchase> custom({
    Expression<String>? product,
    Expression<double>? amount_kg,
    Expression<String>? farmer_number,
  }) {
    return RawValuesInsertable({
      if (product != null) 'product': product,
      if (amount_kg != null) 'amount_kg': amount_kg,
      if (farmer_number != null) 'farmer_number': farmer_number,
    });
  }

  TotalPurchasesCompanion copyWith(
      {Value<String>? product,
      Value<double>? amount_kg,
      Value<String>? farmer_number}) {
    return TotalPurchasesCompanion(
      product: product ?? this.product,
      amount_kg: amount_kg ?? this.amount_kg,
      farmer_number: farmer_number ?? this.farmer_number,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (product.present) {
      map['product'] = Variable<String>(product.value);
    }
    if (amount_kg.present) {
      map['amount_kg'] = Variable<double>(amount_kg.value);
    }
    if (farmer_number.present) {
      map['farmer_number'] = Variable<String>(farmer_number.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TotalPurchasesCompanion(')
          ..write('product: $product, ')
          ..write('amount_kg: $amount_kg, ')
          ..write('farmer_number: $farmer_number')
          ..write(')'))
        .toString();
  }
}

class $TotalPurchasesTable extends TotalPurchases
    with TableInfo<$TotalPurchasesTable, TotalPurchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TotalPurchasesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _productMeta = const VerificationMeta('product');
  @override
  late final GeneratedColumn<String?> product = GeneratedColumn<String?>(
      'product', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amount_kgMeta = const VerificationMeta('amount_kg');
  @override
  late final GeneratedColumn<double?> amount_kg = GeneratedColumn<double?>(
      'amount_kg', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _farmer_numberMeta =
      const VerificationMeta('farmer_number');
  @override
  late final GeneratedColumn<String?> farmer_number = GeneratedColumn<String?>(
      'farmer_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [product, amount_kg, farmer_number];
  @override
  String get aliasedName => _alias ?? 'total_purchases';
  @override
  String get actualTableName => 'total_purchases';
  @override
  VerificationContext validateIntegrity(Insertable<TotalPurchase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product']!, _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('amount_kg')) {
      context.handle(_amount_kgMeta,
          amount_kg.isAcceptableOrUnknown(data['amount_kg']!, _amount_kgMeta));
    } else if (isInserting) {
      context.missing(_amount_kgMeta);
    }
    if (data.containsKey('farmer_number')) {
      context.handle(
          _farmer_numberMeta,
          farmer_number.isAcceptableOrUnknown(
              data['farmer_number']!, _farmer_numberMeta));
    } else if (isInserting) {
      context.missing(_farmer_numberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {product, farmer_number};
  @override
  TotalPurchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TotalPurchase.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TotalPurchasesTable createAlias(String alias) {
    return $TotalPurchasesTable(attachedDatabase, alias);
  }
}

class Farmer extends DataClass implements Insertable<Farmer> {
  final String fullname;
  final String id;
  final String farmer_number;
  Farmer(
      {required this.fullname, required this.id, required this.farmer_number});
  factory Farmer.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Farmer(
      fullname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fullname'])!,
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      farmer_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['fullname'] = Variable<String>(fullname);
    map['id'] = Variable<String>(id);
    map['farmer_number'] = Variable<String>(farmer_number);
    return map;
  }

  FarmersCompanion toCompanion(bool nullToAbsent) {
    return FarmersCompanion(
      fullname: Value(fullname),
      id: Value(id),
      farmer_number: Value(farmer_number),
    );
  }

  factory Farmer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Farmer(
      fullname: serializer.fromJson<String>(json['fullname']),
      id: serializer.fromJson<String>(json['id']),
      farmer_number: serializer.fromJson<String>(json['farmer_number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fullname': serializer.toJson<String>(fullname),
      'id': serializer.toJson<String>(id),
      'farmer_number': serializer.toJson<String>(farmer_number),
    };
  }

  Farmer copyWith({String? fullname, String? id, String? farmer_number}) =>
      Farmer(
        fullname: fullname ?? this.fullname,
        id: id ?? this.id,
        farmer_number: farmer_number ?? this.farmer_number,
      );
  @override
  String toString() {
    return (StringBuffer('Farmer(')
          ..write('fullname: $fullname, ')
          ..write('id: $id, ')
          ..write('farmer_number: $farmer_number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(fullname, id, farmer_number);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Farmer &&
          other.fullname == this.fullname &&
          other.id == this.id &&
          other.farmer_number == this.farmer_number);
}

class FarmersCompanion extends UpdateCompanion<Farmer> {
  final Value<String> fullname;
  final Value<String> id;
  final Value<String> farmer_number;
  const FarmersCompanion({
    this.fullname = const Value.absent(),
    this.id = const Value.absent(),
    this.farmer_number = const Value.absent(),
  });
  FarmersCompanion.insert({
    required String fullname,
    required String id,
    required String farmer_number,
  })  : fullname = Value(fullname),
        id = Value(id),
        farmer_number = Value(farmer_number);
  static Insertable<Farmer> custom({
    Expression<String>? fullname,
    Expression<String>? id,
    Expression<String>? farmer_number,
  }) {
    return RawValuesInsertable({
      if (fullname != null) 'fullname': fullname,
      if (id != null) 'id': id,
      if (farmer_number != null) 'farmer_number': farmer_number,
    });
  }

  FarmersCompanion copyWith(
      {Value<String>? fullname,
      Value<String>? id,
      Value<String>? farmer_number}) {
    return FarmersCompanion(
      fullname: fullname ?? this.fullname,
      id: id ?? this.id,
      farmer_number: farmer_number ?? this.farmer_number,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fullname.present) {
      map['fullname'] = Variable<String>(fullname.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmer_number.present) {
      map['farmer_number'] = Variable<String>(farmer_number.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmersCompanion(')
          ..write('fullname: $fullname, ')
          ..write('id: $id, ')
          ..write('farmer_number: $farmer_number')
          ..write(')'))
        .toString();
  }
}

class $FarmersTable extends Farmers with TableInfo<$FarmersTable, Farmer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _fullnameMeta = const VerificationMeta('fullname');
  @override
  late final GeneratedColumn<String?> fullname = GeneratedColumn<String?>(
      'fullname', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _farmer_numberMeta =
      const VerificationMeta('farmer_number');
  @override
  late final GeneratedColumn<String?> farmer_number = GeneratedColumn<String?>(
      'farmer_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [fullname, id, farmer_number];
  @override
  String get aliasedName => _alias ?? 'farmers';
  @override
  String get actualTableName => 'farmers';
  @override
  VerificationContext validateIntegrity(Insertable<Farmer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('fullname')) {
      context.handle(_fullnameMeta,
          fullname.isAcceptableOrUnknown(data['fullname']!, _fullnameMeta));
    } else if (isInserting) {
      context.missing(_fullnameMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farmer_number')) {
      context.handle(
          _farmer_numberMeta,
          farmer_number.isAcceptableOrUnknown(
              data['farmer_number']!, _farmer_numberMeta));
    } else if (isInserting) {
      context.missing(_farmer_numberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {farmer_number};
  @override
  Farmer map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Farmer.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FarmersTable createAlias(String alias) {
    return $FarmersTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SalesTable sales = $SalesTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $XreportsTable xreports = $XreportsTable(this);
  late final $ZreportsTable zreports = $ZreportsTable(this);
  late final $Buyable_productsTable buyableProducts =
      $Buyable_productsTable(this);
  late final $Sellable_productsTable sellableProducts =
      $Sellable_productsTable(this);
  late final $TotalSalesTable totalSales = $TotalSalesTable(this);
  late final $TotalPurchasesTable totalPurchases = $TotalPurchasesTable(this);
  late final $FarmersTable farmers = $FarmersTable(this);
  late final SalesDao salesDao = SalesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        sales,
        purchases,
        users,
        xreports,
        zreports,
        buyableProducts,
        sellableProducts,
        totalSales,
        totalPurchases,
        farmers
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SalesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SalesTable get sales => attachedDatabase.sales;
}
