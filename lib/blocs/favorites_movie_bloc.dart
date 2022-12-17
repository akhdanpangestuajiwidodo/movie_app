import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/favorites_movie_event.dart';
import 'package:movie_app/blocs/favorites_movie_state.dart';
import 'package:movie_app/models/movie_table_model.dart';
import 'package:movie_app/repositories/movie_local_data_repositories.dart';

class FavoritesMovieBloc
    extends Bloc<FavoritesMovieEvent, FavoritesMovieState> {
  final MovieLocalDataRepositories _localDataRepositories;

  FavoritesMovieBloc(this._localDataRepositories)
      : super(FavoritesMovieInitialState()) {

    on<GetFavoritesMovieEvent>((event, emit) async {
      List<MovieTableModel>? favoriteList;
      try {
        emit(GetFavoritesMovieLoadingState());
        favoriteList = await _localDataRepositories.getFavoriteMovie(event.username);
        print(favoriteList);
        if(favoriteList == null){
          emit(GetFavoritesMovieErrorState('No Has Data'));
        }else{
          emit(GetFavoritesMovieHasDataState(favoriteList));
        }
      } catch (e) {
        emit(GetFavoritesMovieErrorState(e.toString()));
      }
    });

    on<AddFavoritesMovieEvent>((event, emit) async {
      try {
        emit(AddFavoritesMovieLoadingState());
        await _localDataRepositories.addFavoriteMovie(event.movie);
      } catch (e) {
        emit(GetFavoritesMovieErrorState(e.toString()));
      }
    });
  }
}
