

import 'dart:io';
import "package:drift/drift.dart";
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part "database.g.dart";


class Sales extends Table {

  TextColumn get product => text()();
  RealColumn get amount_kg => real()();
  TextColumn get farmer_number => text()();
}

class TotalSales extends Table {

  TextColumn get product => text()();
  RealColumn get amount_kg => real()();
  TextColumn get farmer_number => text()();
  Set<Column> get primaryKey => {product,farmer_number};
}

class Purchases extends Table {

  TextColumn get product => text()();
  RealColumn get amount_kg => real()();
  TextColumn get farmer_number => text()();
}

class TotalPurchases extends Table {

  TextColumn get product => text()();
  RealColumn get amount_kg => real()();
  TextColumn get farmer_number => text()();
  Set<Column> get primaryKey => {product,farmer_number};
}

class Users extends Table {

  TextColumn get username => text()();
  TextColumn get password => text()();
}



// x report

class Xreports extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactions_sold => integer()();
  IntColumn get transactions_bought => integer()();
  RealColumn get units_sold => real()();
  RealColumn get units_bought => real()();
}

class Zreports extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get transactions_sold => integer()();
  IntColumn get transactions_bought => integer()();
  RealColumn get units_sold => real()();
  RealColumn get units_bought => real()();
  TextColumn get username => text()();
}

//make Sellable products
class Sellable_products extends Table {
  TextColumn get product_name => text()();

  Set<Column> get primaryKey => {product_name};
}

//make Buyable_products
class Buyable_products extends Table {
  TextColumn get product_name => text()();

  Set<Column> get primaryKey => {product_name};
}


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    print("Database created successfuly at $dbFolder");
    return NativeDatabase(file);
  });
}

//the annotation tells drift to prepare a databse class that uses both of the
//tables we just defined. well see how to use that databse class in amoment

@DriftDatabase(tables: [Sales,Purchases,Users,Xreports,Zreports,Buyable_products,Sellable_products,TotalSales,TotalPurchases],daos:[SalesDao])
class AppDatabase extends _$AppDatabase{

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  //make a miration strategy for the schemer version 1
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from,to)async
    {
      if(from == 1)
        {
          // await the migrator to make the new tables.
          await migrator.createTable(buyableProducts);
          await migrator.createTable(sellableProducts);
          await migrator.createTable(totalSales);
          await migrator.createTable(totalPurchases);
        }


    }


  );


  //insert ,get ,update and delete For users.

  //insert
  Future<int> insertUser(User) async
  { return await into(users).insert(User);}

  //getlist of object
  Future<List<User>> getUserList() async
  {  return await select(users).get(); }

  //update value in db
  Future<bool> updateUser(User) async
  {
    return await update(users).replace(User);
  }

  //delete object
  Future<int> deleteUser(User) async
  { return await delete(users).delete(User);}





  //insert ,get ,update and delete For Purchases

  //insert
  Future<int> insertPurchase(Purchase) async
  { return await into(purchases).insert(Purchase);}

  //getlist of object
  Future<List<Purchase>> getPurchaseList() async
  {  return await select(purchases).get(); }

  //update value in db
  Future<bool> updatePurchase(Purchase) async
  {
    return await update(purchases).replace(Purchase);
  }

  //delete object
  Future<int> deletePurchase(Purchase) async
  { return await delete(purchases).delete(Purchase);}

  //insert ,get ,update and delete For Xreports

  //insert
  Future<int> insertXreport(Xreport) async
  { return await into(xreports).insert(Xreport);}

  //getlist of object
  Future<List<Xreport>> getXreportList() async
  {  return await select(xreports).get(); }

  //update value in db
  Future<bool> updateXreport(Xreport) async
  {
    return await update(xreports).replace(Xreport);
  }

  //delete object
  Future<int> deleteXreport(Xreport) async
  { return await delete(xreports).delete(Xreport);}


  //insert ,get ,update and delete For Zreports

  //insert
  Future<int> insertZreport(Zreport) async
  { return await into(zreports).insert(Zreport);}

  //getlist of object
  Future<List<Zreport>> getZreportList() async
  {  return await select(zreports).get(); }

  //update value in db
  Future<bool> updateZreport(Zreport) async
  {
    return await update(zreports).replace(Zreport);
  }

  //delete object
  Future<int> deleteZreport(Zreport) async
  { return await delete(zreports).delete(Zreport);}

  // insert get and delete of sellable_products

  //delete object
  Future<int> deleteSellable_product(Sellable_product) async
  { return await delete(sellableProducts).delete(Sellable_product);}

  //insert
  Future<int> insertSellableProduct(Sellable_product) async
  { return await into(sellableProducts).insert(Sellable_product);}

  //getlist of object
  Future<List<Sellable_product>> getSellable_productList() async
  {  return await select(sellableProducts).get(); }

  // insert get and delete of Buyable_products

  //delete object
  Future<int> deleteBuyable_product(Buyable_product) async
  { return await delete(buyableProducts).delete(Buyable_product);}

  //insert
  Future<int> insertBuyableProduct(Buyable_product) async
  { return await into(buyableProducts).insert(Buyable_product);}

  //getlist of object
  Future<List<Buyable_product>> getBuyable_productList() async
  {  return await select(buyableProducts).get(); }
    
  // INSERT UPDATE AND DELETE OF TOTAL SALES TABLE

//insert ,get ,update and delete For TotalSales

  //insert
  Future<int> insertTotalSale(TotalSale) async
  { return await into(totalSales).insert(TotalSale);}

  //getlist of object
  Future<List<TotalSale>> getTotalSaleList() async
  {  return await select(totalSales).get(); }

  Future<List<TotalSale>> getTotalSaleList_of_farmer_number(String farmer_number) async
  {  return await (select(totalSales)..where((tbl) => tbl.farmer_number.equals(farmer_number))).get(); }


  Future<List<TotalSale>> getTotalSaleList_of_product(String product) async
  {  return await (select(totalSales)..where((tbl) => tbl.product.equals(product))).get(); }
  
  Future<List<TotalSale>> getTotalSale_using_farmer_no_and_product({required String farmer_number,required String product}) async
  {  return await (select(totalSales)..where((tbl) => tbl.farmer_number.equals(farmer_number) & tbl.product.equals(product),)).get(); }

  //update value in db
  Future<bool> updateTotalSale(TotalSale) async
  {
    return await update(totalSales).replace(TotalSale);
  }

  //delete object
  Future<int> deleteTotalSale(TotalSale) async
  { return await delete(totalSales).delete(TotalSale);}

  // INSERT UPDATE AND DELETE OF TOTAL PurchaseS TABLE

//insert ,get ,update and delete For TotalPurchases

  //insert
  Future<int> insertTotalPurchase(TotalPurchase) async
  { return await into(totalPurchases).insert(TotalPurchase);}

  //getlist of object
  Future<List<TotalPurchase>> getTotalPurchaseList() async
  {  return await select(totalPurchases).get(); }

  Future<List<TotalPurchase>> getTotalPurchaseList_of_farmer_number(String farmer_number) async
  {  return await (select(totalPurchases)..where((tbl) => tbl.farmer_number.equals(farmer_number))).get(); }


  Future<List<TotalPurchase>> getTotalPurchaseList_of_product(String product) async
  {  return await (select(totalPurchases)..where((tbl) => tbl.product.equals(product))).get(); }

  Future<List<TotalPurchase>> getTotalPurchase_using_farmer_no_and_product({required String farmer_number,required String product}) async
  {  return await (select(totalPurchases)..where((tbl) => tbl.farmer_number.equals(farmer_number) & tbl.product.equals(product) )).get(); }

  //update value in db
  Future<bool> updateTotalPurchase(TotalPurchase) async
  {
    return await update(totalPurchases).replace(TotalPurchase);
  }

  //delete object
  Future<int> deleteTotalPurchase(TotalPurchase) async
  { return await delete(totalPurchases).delete(TotalPurchase);}
}

@DriftAccessor(tables: [Sales])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
 SalesDao(AppDatabase db) : super(db);
//insert ,get ,update and delete For Sales

  //insert
  Future<int> insertSale(Sale) async
  { return await into(sales).insert(Sale);}

  //getlist of object
  Future<List<Sale>> getSaleList() async
  {  return await select(sales).get(); }

  //update value in db
  Future<bool> updateSale(Sale) async
  {
    return await update(sales).replace(Sale);
  }

  //delete object
  Future<int> deleteSale(Sale) async
  { return await delete(sales).delete(Sale);}


}
