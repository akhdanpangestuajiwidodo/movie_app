import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_table_model.dart';

class FavoritesMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesMovieInitialState extends FavoritesMovieState {}

class AddFavoritesMovieLoadingState extends FavoritesMovieState {}

class AddFavoritesMovieErrorState extends FavoritesMovieState {
  final String message;

  AddFavoritesMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetFavoritesMovieLoadingState extends FavoritesMovieState {}

class GetFavoritesMovieHasDataState extends FavoritesMovieState {
  final List<MovieTableModel> movieList;

  GetFavoritesMovieHasDataState(this.movieList);

  @override
  List<Object?> get props => [movieList];
}

class GetFavoritesMovieErrorState extends FavoritesMovieState {
  final String message;

  GetFavoritesMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class CheckFavoriteMovieLoadingState extends FavoritesMovieState {}

class CheckFavoriteMovieIsSaveState extends FavoritesMovieState {
  final bool isSaved;

  CheckFavoriteMovieIsSaveState(this.isSaved);

  @override
  List<Object?> get props => [isSaved];
}

class CheckFavoritesMovieErrorState extends FavoritesMovieState {
  final String message;

  CheckFavoritesMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteFavoritesMovieLoadingState extends FavoritesMovieState {}

class DeleteFavoritesMovieErrorState extends FavoritesMovieState {
  final String message;

  DeleteFavoritesMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
