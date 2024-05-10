// ignore_for_file: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  static Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'prestigeApp.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE myCards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cardHolderName TEXT,
            cardNumber TEXT,
            expiryDate TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE payment (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount TEXT,
            currency TEXT,
            valetId TEXT,
            valetName TEXT,
            gateName TEXT,
            retrieveCarModel TEXT
          )
        ''');
      },
      version: 1,
    );
  }

 static Future<List<Map<String, dynamic>>> getCards() async {
    final db = await database;
    return await db.query('myCards');
  }

  static Future<int> insertCard(Map<String, dynamic> card) async {
    final db = await database;
    return await db.insert('myCards', card);
  }

  static Future<int> updateCard(Map<String, dynamic> card,int cardId) async {
    final db = await database;
    return await db
        .update('myCards', card, where: 'id = $cardId');
  }

  static Future<Map<String, dynamic>> getPayment() async {
    final db = await database;
    return (await db.rawQuery("SELECT * FROM payment")).isEmpty
        ? {}
        : (await db.rawQuery("SELECT * FROM payment")).last;
  }

  static Future<void> deletePaymentTableRecords() async {
    final db = await database;
    await db.rawDelete('DELETE FROM `payment`');
  }

  static Future<void> insertPayment({
    required String amount,
    required String currency,
    required String valetId,
    required String valetName,
    required String gateName,
    required String retrieveCarModel,
  }) async {
    final db = await database;
    await db.insert(
      'payment',
      {
        'amount': amount,
        'currency': currency,
        'valetId': valetId,
        'valetName': valetName,
        'gateName': gateName,
        'retrieveCarModel': retrieveCarModel,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<bool> checkIfTableExist() async {
    return (await getPayment()).isNotEmpty;
  }
}
