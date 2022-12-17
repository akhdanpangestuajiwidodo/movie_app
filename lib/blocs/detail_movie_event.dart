import 'package:equatable/equatable.dart';
import 'package:movie_app/models/detail_movie_model.dart';

class DetailMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final int id;

  GetDetailMovieEvent(this.id);
}
