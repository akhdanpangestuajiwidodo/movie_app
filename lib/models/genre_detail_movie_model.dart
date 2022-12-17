import 'package:equatable/equatable.dart';

class GenreDetailMovieModel extends Equatable {
  GenreDetailMovieModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreDetailMovieModel.fromJson(Map<String, dynamic> json) =>
      GenreDetailMovieModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  List<Object?> get props => [id, name];
}
