import 'package:perpustakaan_app/model/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static late Database _database;

  static const String _dbName = 'library.db';
  static const String _bookTable = 'book';

  Future<Database> initializeDb() async {
    final path = await getDatabasesPath();
    final db = await openDatabase(
      join(path, _dbName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_bookTable (id INTEGER PRIMARY KEY, title TEXT, author TEXT)
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    _database = await initializeDb();

    return _database;
  }

  Future<int> insertBook(Book book) async {
    final db = await database;

    return await db.insert(_bookTable, book.toJson());
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final mapBook = await db.query(_bookTable);

    return Book.toBooks(mapBook);
  }

  Future<Book?> getBook(Book book) async {
    final db = await database;
    final map =
        await db.query(_bookTable, where: 'id = ?', whereArgs: [book.id]);

    if (map.isNotEmpty) {
      return Book.fromJson(map[0]);
    } else {
      return null;
    }
  }

  Future<int> delete(Book book) async {
    final db = await database;

    return await db.delete(_bookTable, where: 'id = ?', whereArgs: [book.id]);
  }
}
