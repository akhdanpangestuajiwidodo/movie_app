import 'package:movie_app/models/movie_table_model.dart';

abstract class MovieLocalDataInterface{
  Future<void> addFavoriteMovie(MovieTableModel movie);
  Future<List<MovieTableModel>?> getFavoriteMovie(String username);
  Future<bool> getByTitleAndUsername(MovieTableModel movie);
  Future<int> deleteFavoriteMovie(MovieTableModel movie);
}