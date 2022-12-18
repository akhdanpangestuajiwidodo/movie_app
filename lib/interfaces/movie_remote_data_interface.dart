import 'package:movie_app/models/detail_movie_model.dart';
import 'package:movie_app/models/movie_model.dart';

abstract class MovieRemoteDataInterface{
  Future<List<MovieModel>?> getNowPlayingMovies(int page);
  Future<DetailMovieModel?> getDetailMovie(int id);
}