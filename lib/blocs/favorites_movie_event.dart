import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_table_model.dart';

class FavoritesMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFavoritesMovieEvent extends FavoritesMovieEvent {
  final String username;

  GetFavoritesMovieEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class AddFavoritesMovieEvent extends FavoritesMovieEvent {
  final MovieTableModel movie;

  AddFavoritesMovieEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}

class CheckFavoriteMovieIsSavedEvent extends FavoritesMovieEvent {
  final MovieTableModel movie;

  CheckFavoriteMovieIsSavedEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}

class DeleteFavoritesMovieEvent extends FavoritesMovieEvent {
  final MovieTableModel movie;

  DeleteFavoritesMovieEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}
