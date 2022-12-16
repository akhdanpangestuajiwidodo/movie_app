import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_model.dart';

class PlayingMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayingMovieInitialState extends PlayingMovieState {}

class PlayingMovieLoadingState extends PlayingMovieState {}

class PlayingMovieHasDataState extends PlayingMovieState {
  final List<MovieModel> movieList;

  PlayingMovieHasDataState(this.movieList);

  @override
  List<Object?> get props => [movieList];
}

class PlayingMovieErrorState extends PlayingMovieState {
  final String message;

  PlayingMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
