import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite_restaurant.dart';

class DatabaseHelper {

  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDb();

    return _database!;
  }

  Future<Database> _initDb() async {

    final path = join(await getDatabasesPath(), 'restaurant.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY,
            name TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
        ''');

      },
      version: 1,
    );
  }

  Future<void> insertFavorite(FavoriteRestaurant restaurant) async {

    final db = await database;

    await db.insert(
      'favorites',
      restaurant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FavoriteRestaurant>> getFavorites() async {

    final db = await database;

    final result = await db.query('favorites');

    return result.map((e) => FavoriteRestaurant.fromMap(e)).toList();
  }

  Future<bool> isFavorite(String id) async {

    final db = await database;

    final result =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);

    return result.isNotEmpty;
  }

  Future<void> removeFavorite(String id) async {

    final db = await database;

    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}