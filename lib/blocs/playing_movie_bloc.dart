import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/playing_movie_event.dart';
import 'package:movie_app/blocs/playing_movie_state.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_remote_data_repositories.dart';

class PlayingMovieBloc extends Bloc<PlayingMovieEvent, PlayingMovieState> {
  int page = 1;
  final MovieRemoteDataRepositories _movieRemoteDataRepositories;

  PlayingMovieBloc(this._movieRemoteDataRepositories)
      : super(PlayingMovieInitialState()) {
    on<GetPlayingMovieEvent>((event, emit) async {
      List<MovieModel>? movieList;
      try {
        emit(PlayingMovieLoadingState());
        movieList = await _movieRemoteDataRepositories.getNowPlayingMovies(page);
        page++;
        if (movieList == null) {
          emit(PlayingMovieErrorState('No Has Data'));
        } else {
          emit(PlayingMovieHasDataState(movieList));
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          }
        }
      } on SocketException catch (_) {
        emit(PlayingMovieErrorState('Internet not connected'));
      } on Exception catch (e) {
        emit(PlayingMovieErrorState(e.toString()));
      }
    });
  }
}
