import 'package:equatable/equatable.dart';

class DetailMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final int id;

  GetDetailMovieEvent(this.id);
}
