import 'package:movie_app/interfaces/movie_local_data_interface.dart';
import 'package:movie_app/models/movie_table_model.dart';
import 'package:sqflite/sqflite.dart';

class MovieLocalDataRepositories implements MovieLocalDataInterface {
  static MovieLocalDataRepositories? _instanceDatabaseHelper;

  MovieLocalDataRepositories._instance() {
    _instanceDatabaseHelper = this;
  }

  factory MovieLocalDataRepositories() =>
      _instanceDatabaseHelper ?? MovieLocalDataRepositories._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  static const String _tbFavoriteMovie = 'favorites';

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final db = openDatabase(
      '$path/favorites.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tbFavoriteMovie (
             id INTEGER PRIMARY KEY,
             title TEXT,
             overview TEXT,
             city TEXT,
             posterPath TEXT,
             username TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  @override
  Future<void> addFavoriteMovie(MovieTableModel movie) async {
    print("masuk ke addFavorite repo ${movie.username}, ${movie.title}");
    final db = await database;
      await db!.insert(
        _tbFavoriteMovie,
        movie.toJson(),
      );
  }

  Future<dynamic> _getByTitleAndUsername(String username, String title) async {
    final db = await database;
    final result = await db!
        .query(_tbFavoriteMovie, where: 'username = ? and title = ?', whereArgs: [username, title]);
    return result.first;
  }

  @override
  Future<List<MovieTableModel>?> getFavoriteMovie(String username) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!
        .query(_tbFavoriteMovie, where: 'username = ?', whereArgs: [username]);

    return result.map((e) => MovieTableModel.fromJson(e)).toList();
  }
}