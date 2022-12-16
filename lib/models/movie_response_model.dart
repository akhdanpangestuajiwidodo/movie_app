import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieResponseModel extends Equatable {
  MovieResponseModel({required this.movieList});

  final List<MovieModel> movieList;

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieResponseModel(
          movieList: List<MovieModel>.from((json["results"] as List)
              .map((movie) => MovieModel.fromJson(movie))));

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((movie) => movie.toJson())),
      };

  @override
  List<Object?> get props => [movieList];
}
