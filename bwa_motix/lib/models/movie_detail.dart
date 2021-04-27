part of 'models.dart';

class MovieDetail extends Movie {
  //  extends Movie karena beberapa atribut yang diperlukan terdapat di dalam class Movie
  // jadi turunan dari Movie..
  final List<String> genres;
  final String language;

  // MovieDetail perlu Movie , dan atribut dalam Movie akan di copy ke dalam parameter genre dan languanges.
  // super (memanggil parent).
  //
  MovieDetail(Movie movie, {this.genres, this.language})
      : super(
            id: movie.id,
            title: movie.title,
            voteAverage: movie.voteAverage,
            overview: movie.overview,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath);

  // getter untuk get genre dan languanges.
  // untuk yang dibawah judul bagia movie detail.
  // pake getter karena ditempat lain (tempat beli tiket, dll)kita akan pakai itu juga, jadi pake getter aja.

  String get genresAndLanguage {
    String s = "";

    for (var genre in genres) {
      s += genre + (genre != genres.last ? ', ' : '');
    }

    return "$s - $language";
  }

  @override
  List<Object> get props => super.props + [genres, language];
}
