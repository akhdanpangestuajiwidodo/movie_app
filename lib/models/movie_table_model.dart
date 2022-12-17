import 'package:equatable/equatable.dart';

class MovieTableModel extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String username;

  MovieTableModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.username,
  });

  factory MovieTableModel.fromJson(Map<String, dynamic> json) => MovieTableModel(
    id: json['id'],
    title: json['title'],
    posterPath: json['posterPath'],
    overview: json['overview'],
    username: json['username'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'posterPath': posterPath,
    'overview': overview,
    'username': username,
  };

  @override
  List<Object?> get props => [id, title, posterPath, overview, username];
}