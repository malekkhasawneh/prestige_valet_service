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
      join(path, 'wallet.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE myCards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cardHolderName TEXT,
            cardNumber TEXT,
            expiryDate TEXT
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
}
