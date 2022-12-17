import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/detail_movie_event.dart';
import 'package:movie_app/blocs/detail_movie_state.dart';
import 'package:movie_app/models/detail_movie_model.dart';

import '../repositories/movie_remote_data_repositories.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final MovieRemoteDataRepositories _movieRemoteDataRepositories;
  
  DetailMovieBloc(this._movieRemoteDataRepositories):super(DetailMovieInitialState()){
    on<GetDetailMovieEvent>((event, emit) async{
      DetailMovieModel? movie;
      try {
        emit(DetailMovieLoadingState());
        movie = await _movieRemoteDataRepositories.getDetailMovie(event.id);
        if (movie == null) {
          emit(DetailMovieErrorState('No Has Data'));
        } else {
          emit(DetailMovieHasDataState(movie));
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          }
        }
      } on SocketException catch (_) {
        emit(DetailMovieErrorState('Internet not connected'));
      } on Exception catch (e) {
        emit(DetailMovieErrorState(e.toString()));
      }
    });
  }
}
