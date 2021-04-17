part of 'models.dart';

class Movie extends Equatable {
  final int id; // id movie
  final String title; // judul
  final double voteAverage; // rating
  final String overview; // deskripsi
  final String posterPath; // path untuk gambar poster
  final String backdropPath; // path untuk gambar backdrop

  Movie(
      { // required = harus diisi
      @required this.id,
      @required this.title,
      @required this.voteAverage,
      @required this.overview,
      @required this.posterPath,
      @required this.backdropPath});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      id: json['id'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path']);

  @override
  List<Object> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath];
}
