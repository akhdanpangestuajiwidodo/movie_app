import 'package:equatable/equatable.dart';

import '../models/detail_movie_model.dart';

class DetailMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailMovieInitialState extends DetailMovieState {}

class DetailMovieLoadingState extends DetailMovieState {}

class DetailMovieHasDataState extends DetailMovieState {
  final DetailMovieModel movie;

  DetailMovieHasDataState(this.movie);

  @override
  List<Object?> get props => [movie];
}

class DetailMovieErrorState extends DetailMovieState {
  final String message;

  DetailMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
