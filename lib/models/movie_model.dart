import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      MovieModel(
        adult: json["adult"],
        backdropPath: json["backdropPath"],
        genreIds: List<int>.from(json["genreIds"].map((x) => x)),
        id: json["id"],
        originalTitle: json["originalTitle"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["posterPath"],
        releaseDate: json["releaseDate"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["voteAverage"],
        voteCount: json["voteCount"],
      );

  Map<String, dynamic> toJson() =>
      {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount
  ];
}
