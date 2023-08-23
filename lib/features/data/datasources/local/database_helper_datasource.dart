import 'package:breed_challenge/features/data/datasources/local/idatabase_helper_datasource.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperDataSource implements IDatabaseHelperDataSource {
  static final DatabaseHelperDataSource instance = DatabaseHelperDataSource._();

  static Database? _database;

  DatabaseHelperDataSource._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      'favorites.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            breedName TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  @override
  Future<List<String>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (index) {
      return maps[index]['breedName'] as String;
    });
  }

  @override
  Future<void> addFavorite(String breedName) async {
    final db = await database;
    await db.insert('favorites', {'breedName': breedName});
  }

  @override
  Future<void> removeFavorite(String breedName) async {
    final db = await database;
    await db
        .delete('favorites', where: 'breedName = ?', whereArgs: [breedName]);
  }
}
