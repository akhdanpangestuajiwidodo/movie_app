import 'package:movie_app/models/movie_model.dart';

abstract class MovieRemoteDataInterface{
  Future<List<MovieModel>?> getNowPlayingMovies();
}