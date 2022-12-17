import 'package:equatable/equatable.dart';

class PlayingMovieEvent extends Equatable {
  const PlayingMovieEvent();

  @override
  List<Object> get props => [];
}

class GetPlayingMovieEvent extends PlayingMovieEvent {}
